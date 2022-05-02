import org.sonatype.nexus.security.realm.RealmManager

repository.createDockerHosted('docker_repo',
                               7000,
                               null,
                               'default')

container.lookup(RealmManager.class.getName()).enableRealm('DockerToken', true)
