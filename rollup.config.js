import path from "path";
import elm from "rollup-plugin-elm";
import serve from "rollup-plugin-serve";
import livereload from "rollup-plugin-livereload";
import remove from "rollup-plugin-delete";
import copy from "rollup-plugin-copy";
import postcss from "rollup-plugin-postcss";
import {terser} from "rollup-plugin-terser";
import autoprefixer from "autoprefixer";
import cssnano from "cssnano";

export default {
  input: path.resolve("src", "siren.js"),
  plugins: [
    remove({
      runOnce: true,
      verbose: true,
      targets: [
        path.resolve("docs", "**", "*")
      ]
    }),
    copy({
      verbose: true,
      targets: [
        {
          src: path.resolve("src", "static", "**", "*"),
          dest: path.resolve("docs")
        }
      ]
    }),
    postcss({
      extract: path.resolve("docs", "siren.css"),
      plugins: [
        process.env.NODE_ENV === "production" && autoprefixer(),
        process.env.NODE_ENV === "production" && cssnano()
      ]
    }),
    elm({
      compiler: {
        optimize: process.env.NODE_ENV === "production",
        debug: process.env.NODE_ENV === "development"
      }
    }),
    process.env.NODE_ENV === "development" && serve({
      open: false,
      verbose: true,
      contentBase: path.resolve("docs"),
      historyApiFallback: false,
      host: "0.0.0.0",
      port: 8000
    }),
    process.env.NODE_ENV === "development" && livereload({
      watch: path.resolve("docs"),
      verbose: true
    }),
    process.env.NODE_ENV === "production" && terser({
      mangle: true,
      compress: {
        pure_funcs: ["F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9"],
        pure_getters: true,
        keep_fargs: false,
        unsafe_comps: true,
        unsafe: true
      }
    })
  ],
  output: {
    file: path.resolve("docs", "siren.js"),
    format: "iife"
  }
};
