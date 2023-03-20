Prereqs
-------
1. Install OpenAI Python CLI: `pip3 install openai`
1. Get an OpenAI API key and set it: `export OPENAI_API_KEY="sk...."` (preferably in shell)

Training & Tuning
-----------------
1. Run the Python script to compile the training data into a `.jsonl` file that can be used for fine-tuning (see [here](https://platform.openai.com/docs/guides/fine-tuning/advanced-usage))
1. Fine-tune a model using the training data: `openai api fine_tunes.create -t output.jsonl`

TODO
----
- Add validation dataset 
- Somehow hook this up to the Starlark compiler to ensure it compiles?
- Use the Codex model, and the best practices on:
    - https://platform.openai.com/docs/guides/code/best-practices
    - https://microsoft.github.io/prompt-engineering/
- Try out stuff with Codex on the playground: https://platform.openai.com/playground?model=code-davinci-002&prompt=%22%22%22%0AAsk%20the%20user%20for%20their%20name%20and%20say%20%22Hello%22%0A%22%22%22
