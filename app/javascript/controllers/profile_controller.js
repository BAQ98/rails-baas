import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["skillTags", "skillInput"];

  connect() {}

  initialize() {
    this.skills = JSON.parse(this.skillTagsTarget.dataset.skills) || [];
  }

  getElement() {
    const tagListItemTemplateId = this.data.get("tagListItemTemplateId");
    const tagEmptyTemplateId = this.data.get("tagEmptyTemplateId");

    const cloneNodeTemplate = (templateId) => {
      return document.getElementById(templateId).content.cloneNode(true);
    };

    return {
      skillTagListItemClone: cloneNodeTemplate(tagListItemTemplateId),
      skillTagEmptyClone: cloneNodeTemplate(tagEmptyTemplateId),
    };
  }

  isValidValue() {
    if (this.skillInputTarget.value === "") return false;
    if (this.skills.some((item) => item === this.skillInputTarget.value))
      return false;
    return true;
  }

  clickToRemoveTag(e) {
    const tagElement = e.target.closest("li");
    tagElement.remove();
    const index = this.skills.indexOf(e.currentTarget.dataset.value);
    if (index > -1) {
      this.skills.splice(index, 1);
    }

    if (this.skills.length === 0) {
      this.skillTagsTarget.appendChild(this.getElement().skillTagEmptyClone);
    }
  }

  backspaceToRemoveTag(e) {
    const lastLi = this.skillTagsTarget.querySelector("li:last-child");
    if (e.key === "Backspace" && this.skillInputTarget.value === "" && lastLi) {
      this.skills.pop();
      lastLi.remove();
      if (this.skills.length === 0) {
        this.skillTagsTarget.appendChild(this.getElement().skillTagEmptyClone);
      }
    }
  }

  insertSkillTag(e) {
    e.preventDefault();
    e.stopImmediatePropagation();

    const emptyInput = this.skillTagsTarget.querySelector(
      '[data-input="empty"]',
    );

    if (emptyInput) emptyInput.remove();

    if (this.isValidValue()) {
      const { skillTagEmptyClone, skillTagListItemClone } = this.getElement();
      const span = skillTagListItemClone.querySelector("span");
      const input = skillTagListItemClone.querySelector("input");
      const button = skillTagListItemClone.querySelector("button");

      span.textContent = this.skillInputTarget.value;
      input.setAttribute("value", this.skillInputTarget.value);
      button.dataset.value = this.skillInputTarget.value;

      this.skills.push(this.skillInputTarget.value);
      this.skillTagsTarget.appendChild(skillTagListItemClone);
      this.skillInputTarget.value = "";
    }
    console.log(this.skills);
  }
}
