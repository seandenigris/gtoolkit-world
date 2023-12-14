Class {
	#name : #GtGitRepositoryWithoutGitAttributes,
	#superclass : #GtLeafConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtGitRepositoryWithoutGitAttributes class >> instance [
	<gtExample>
	^ self new
]

{ #category : #accessing }
GtGitRepositoryWithoutGitAttributes >> description [
	^ 'All repositories in the Feenk organisation that contain smalltalk code should include a .gitattributes file that ensure unix line endings for all commits'
]

{ #category : #accessing }
GtGitRepositoryWithoutGitAttributes >> issues [
	| project directories |
	project := GtGhGToolkitProject default.
	directories := project ownedRepositories collect: [ :aRepository | 
		aRepository baselineRepository icebergRepository workingCopy fileSystem ].
	^ directories select: [ :aDirectory | 
		(aDirectory / '.gitattributes') exists not and:
			[ (aDirectory / 'src') exists and:
			[ ((aDirectory / 'src') allChildrenMatching: '*.st') isNotEmpty ] ] ]
]

{ #category : #accessing }
GtGitRepositoryWithoutGitAttributes >> name [ 
	^ 'Git repositories from feenkcom with smalltalk code should include .gitattributes'
]