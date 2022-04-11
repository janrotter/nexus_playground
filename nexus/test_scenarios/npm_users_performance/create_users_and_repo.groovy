import org.sonatype.nexus.security.realm.RealmManager


for(int i in 1..10000) {
  security.addRole("role${i}", "role${i}", "somerole", [], [])
  security.addUser("user${i}", "firstName", "lastName", "some@localhost", true, "pass", ["role${i}"]);
}

repository.createNpmProxy("npm-proxy",
  "https://registry.npmjs.org",
  "default",
  true);

container.lookup(RealmManager.class.getName()).enableRealm('NpmToken', true)
