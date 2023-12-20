- [ ] go语言debug问题，一旦main包和go.mod不在同一个文件夹下就无法debug
- [ ] 文件浏览tree，快速定位文件或者文件夹
- [ ] tab切换只能相邻的tab切换，需要不同tab之间快速切换

---

## 说明

这个Trans.json是放在这个插件的目录下(这挺麻烦，作者应该改一下)，也就是`$HOME/.local/share/lunarvim/site/pack/lazy/opt/Trans.nvim` (如果没用用neovim就是.local/share/nvim，总之在这下面就是了)

我使用的是百度的api, 去百度开发者翻译那开通一个就行。填上对应的uri以及id和密码

**下面是搭配我自己写的一个函数的使用情况**

绑定了`<C-i>` 作为快捷键，每次`<C-i>` 则自动翻译下一个段落。

![一个巨大(13mb)的gif](./util_translate.gif)
