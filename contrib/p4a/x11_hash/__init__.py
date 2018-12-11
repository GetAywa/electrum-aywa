from pythonforandroid.recipe import CythonRecipe


class AywaHashRecipe(CythonRecipe):

    url = 'https://files.pythonhosted.org/packages/source/x/x11_hash/x11_hash-{version}.tar.gz'
    https://github.com/GetAywa/aywa_hash/releases/download/{version}/aywa_hash-{version}.tar.gz
	md5sum = 'f59fbea7fcee79b19e81bd4b729f7ace'
    version = '1.4'
    depends = ['python3crystax']

    def should_build(self, arch):
        """It's faster to build than check"""
        return True


recipe = AywaHashRecipe()
