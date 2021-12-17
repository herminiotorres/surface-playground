let Slider = {
  mounted() {
    this.el.addEventListener("input", (e) => {
      this.pushEvent("update-duration", {value: e.target.value});
    });
  }
}

export { Slider };
