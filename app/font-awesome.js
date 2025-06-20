import { config } from '@fortawesome/fontawesome-svg-core';
import '@fortawesome/fontawesome-svg-core/styles.css'; // This adds the basic icon styles into your app

// Disable auto CSS import into head. It solved the side effect for jumping icon size.
// This is required for Fastboot apps, otherwise build fails
// It's the recommended way for setup Font Awesome in your app
config.autoAddCss = false;
