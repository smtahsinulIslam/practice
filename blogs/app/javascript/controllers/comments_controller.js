import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    initialize() {}
  connect() {}
  toggleEditForm(event) {
    console.log("toggleEditForm called");
    event.preventDefault();
    event.stopPropagation();

    const editCommentFormPeramId = event.params["editCommentFormPeram"];
    const commentTextId = event.params["commentText"];
    
    const commentForm = document.getElementById(editCommentFormPeramId)    
    if(commentForm) commentForm.classList.toggle("hidden");

    const commentText = document.getElementById(commentTextId)
    if(commentText) commentText.classList.toggle("hidden");

  }
}