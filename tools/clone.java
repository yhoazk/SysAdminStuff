/**
 * 
 */
package com.Test;

import java.io.File;
import java.io.IOException;

import org.eclipse.jgit.api.CloneCommand;
import org.eclipse.jgit.api.Git;
import org.eclipse.jgit.api.errors.GitAPIException;
import org.eclipse.jgit.transport.UsernamePasswordCredentialsProvider;



/**
 * Simple snippet which shows how to clone a repository from a remote source
 *
 * @author dominik.stadler at gmx.at
 */
public class main {

    private static final String REMOTE_URL = "https://github.com/github/testrepo.git";

    public static void main(String[] args) throws IOException, GitAPIException {
        // prepare a new folder for the cloned repository
        File localPath = File.createTempFile("TestGitRepository", "");
        if(!localPath.delete()) {
            throw new IOException("Could not delete temporary file " + localPath);
        }

        // then clone
        try {
        System.out.println("Cloning from " + REMOTE_URL + " to " + localPath);
        CloneCommand clonecmd = Git.cloneRepository();
        clonecmd.setURI(REMOTE_URL).setDirectory(localPath);
        clonecmd.setCredentialsProvider(new UsernamePasswordCredentialsProvider("user", "passwd")).call();
        }
        catch (Exception k)
        {
        	System.out.println("Failed: " + k.getMessage());
        }
        
        System.out.println("Having repository: ");
        
        /*
        try (Git result = Git.cloneRepository()
                .setURI(REMOTE_URL)
                .setDirectory(localPath)
                .call()) {
	        // Note: the call() returns an opened repository already which needs to be closed to avoid file handle leaks!
	        
        }*/
    }
}
