'use strict'

angular.module('AdminApp')
.directive 'markdownEditor', ['$modal',
  ($modal) -> {
    require: 'ngModel'
    restrict: 'A'
    link: ($scope, $element, attrs, ngModel) ->
      btnImage = {
        name: 'cmdAttachedImage'
        title: 'Image'
        icon: {
          'glyph': 'glyphicon glyphicon-picture'
          'fa': 'fa fa-picture-o'
          'fa-3': 'icon-picture'
        }
        callback: (e) ->
          ($modal.open {
            animation: false
            templateUrl: 'partials/editor/imageSelect.html'
            controller: 'EditorImageSelectController'
            resolve: {
              imageList: ->
                for item in $scope.$eval(attrs.attachments)
                  item.href
            }
          }).result.then (link) ->
            selected = e.getSelection()
            content = e.getContent()

            chunk =
              unless selected.length then e.__localize 'enter image description here'
              else selected.text

            e.replaceSelection "![#{chunk}](#{link} \"#{e.__localize 'enter image title here'}\")"
      }

      $element.markdown {
        additionalButtons: [
          [
            name: 'groupCustom'
            data: [btnImage]
          ]
        ]
        onChange: (e) ->
          ngModel.$setViewValue e.getContent()
      }
  }
]
.controller 'EditorImageSelectController', [
  '$scope', '$modalInstance', 'imageList',
  ($scope, $modalInstance, imageList) ->
    $scope.imageList = imageList
    $scope.done = (link) ->
      $modalInstance.close(link)
]
