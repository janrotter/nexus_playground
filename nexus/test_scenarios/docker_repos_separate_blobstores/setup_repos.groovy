import org.sonatype.nexus.security.realm.RealmManager
blobStore.createFileBlobStore('blobstore_a', 'blobstore_a');
blobStore.createFileBlobStore('blobstore_b', 'blobstore_b');

repository.createDockerHosted('docker_repo_a',
                               7000,
                               null,
                               'blobstore_a')
repository.createDockerHosted('docker_repo_b',
                               7001,
                               null,
                               'blobstore_b')

container.lookup(RealmManager.class.getName()).enableRealm('DockerToken', true)
