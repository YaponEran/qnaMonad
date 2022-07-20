import Turbolinks from "turbolinks";
import Rails from '@rails/ujs';


import "../src/terra/scss/terra.scss"
import "../src/terra/js/ui/modal_trigger"
require("channels")
require("@rails/activestorage").start()

Turbolinks.start();
Rails.start();