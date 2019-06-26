clean:
	rm -rf wesley.zip walter.zip

zip: clean
	mkdir -p tmp
	zip -r wesley.zip wesley -x@.gitignore
	zip -r walter.zip walter -x@.gitignore

prerelease:
	github-release upload \
	    --owner banjocat \
	    --repo shorturl \
	    --tag ${BUILD} \
	    --name ${BUILD} \
	    --prerelease
	    wesley.zip walter.zip

release:
	github-release upload \
	    --owner banjocat \
	    --repo shorturl \
	    --tag ${BUILD} \
	    --name ${BUILD} \
	    wesley.zip walter.zip

delete-relesae:
	github-release delete \
	  --owner banjocat \
	  --repo shorturl \
	  --tag ${BUILD}
