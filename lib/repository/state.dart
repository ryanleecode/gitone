import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

enum ReferenceType { Local, Remote, Tag, Head, Unknown }

@immutable
@JsonSerializable()
class Reference {
  final ReferenceType type;

  final String name;

  Reference(this.name, {this.type});

  factory Reference.fromJson(Map<String, dynamic> json) =>
      _$ReferenceFromJson(json);

  Map<String, dynamic> toJson() => _$ReferenceToJson(this);

  @override
  String toString() {
    return 'Reference{name: $name, type: $type}';
  }
}

@immutable
@JsonSerializable()
class Commit {
  final String hash;
  final String summary;
  final List<Reference> references;

  Commit({this.hash, this.summary, this.references});

  factory Commit.fromJson(Map<String, dynamic> json) => _$CommitFromJson(json);

  Map<String, dynamic> toJson() => _$CommitToJson(this);

  @override
  String toString() {
    return 'Commit{hash: $hash, summary: $summary}';
  }
}

@immutable
@JsonSerializable()
class RepositoryState {
  final String url;
  final Map<String, Commit> commits;
  final String selectedHash;
  final List<Change> changes;

  RepositoryState(
      {this.url = "",
      this.commits = const {},
      this.selectedHash = "",
      this.changes = const []});

  RepositoryState copyWith(
      {String url,
      Map<String, Commit> commits,
      String selectedHash,
      List<Change> changes}) {
    return RepositoryState(
        url: url ?? this.url,
        commits: commits ?? this.commits,
        selectedHash: selectedHash ?? this.selectedHash,
        changes: changes ?? this.changes);
  }

  factory RepositoryState.fromJson(Map<String, dynamic> json) =>
      _$RepositoryStateFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryStateToJson(this);

  @override
  String toString() {
    return 'RepositoryState{url: $url, commits: $commits}';
  }
}

enum ChangeType { INSERT, MODIFY, DELETE }

@immutable
@JsonSerializable()
class Change {
  final ChangeType type;

  final String filePath;

  Change({this.type, this.filePath});

  factory Change.fromJson(Map<String, dynamic> json) => _$ChangeFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeToJson(this);

  @override
  String toString() {
    return 'Change{type: $type, filePath: $filePath}';
  }
}
