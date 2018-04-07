PWD = $(shell pwd)
REPO = irreverentpixelfeats/fp-course
BASE_TAG = ubuntu_xenial-8.0.2_1.24

.PHONY: deps build image all

data/version:
	bin/git-version ./latest-version
	diff -q latest-version data/version || cp -v latest-version data/version
	rm latest-version

deps: data/version

build: deps Dockerfile
	docker pull "${REPO}:${BASE_TAG}" || true
	docker build --cache-from "${REPO}:${BASE_TAG}" --tag "${REPO}:${BASE_TAG}" --tag "${REPO}:${BASE_TAG}-$(shell cat data/version)" .

fp-course-${BASE_TAG}.tar.gz: build
	docker image save -o "fp-course-${BASE_TAG}.tar" "${REPO}:${BASE_TAG}"
	gzip -v "fp-course-${BASE_TAG}.tar"

image: fp-course-${BASE_TAG}.tar.gz

all: build image
