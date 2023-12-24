echo 'Starting up gguf memesooGPT server'
if [ -z ${LLAMA_MODEL_NAME} ];
    then 
        echo 'LLAMA_MODEL_NAME is unset or set to blank';
        echo 'Setting it to default wizardlm-1.0-uncensored-llama2-13b.Q5_K_M.gguf'
        LLAMA_MODEL_NAME='wizardlm-1.0-uncensored-llama2-13b.Q5_K_M.gguf'
        PROMPT_TYPE='vicuna11'
    else
        echo "LLAMA_MODEL_NAME is set to $LLAMA_MODEL_NAME"
fi

if [ -z ${PROMPT_TYPE} ];
    then 
        echo 'PROMPT_TYPE is unset or set to blank';
        echo 'Setting it to default llama'
        set PROMPT_TYPE='llama'
    else
        echo "PROMPT_TYPE is set to $PROMPT_TYPE"
fi

#openassistanc - open_assistant
#speechless - wizard2
#wizardvicuna - vicuna11
#wizardlm - vicuna11

H2OGPT_ENABLE_HEAP_ANALYTICS=False HF_DATASETS_OFFLINE=1 TRANSFORMERS_OFFLINE=1 \
python generate.py \
--enable_heap_analytics=False \
--gradio_offline_level=2 \
--base_model=llama \
--model_path_llama=model_collection/${LLAMA_MODEL_NAME} \
--llamacpp_dict="{'n_gpu_layers':12}" \
--prompt_type=$PROMPT_TYPE \
--save_dir='/workspace/save/' \
--temperature=0.4 \
--do_sample=True \
--repetition_penalty=1.17 \
--langchain_mode=MyData \
--user_path="user_data" \
--chat=True \
--show_copy_button=True \
--hf_embedding_model="sentence-transformers/all-MiniLM-L6-v2" \
--use_llm_if_no_docs=True \
--visible_h2ogpt_logo=True \
--visible_login_tab=False \
--visible_models_tab=False \
--visible_langchain_agents='[]' \
--height=450 \
--auth='/workspace/h2ogpt_auth/auth.json' \
--auth_message='!!DO NOT USE REALWORLD PSWD!! 
The login is for persisting session. 
Freely make a new id/pswd pair. 
PSWD WILL BE SAVED IN PLAIN TEXT' \
&

# run_docker.sh
# sudo docker run \
# -p 8081:7860 \
# --rm -it \
#      -v ./_h2ogpt_env/.cache/:/workspace/.cache \
#        -v ./_h2ogpt_env/save/:/workspace/save \
#   -v ./_h2ogpt_env/user_data/:/workspace/user_data \
#  -v ./_h2ogpt_env/user_paste/:/workspace/user_paste \
#       -v ./_h2ogpt_env/users/:/workspace/users \
#   -v ./_h2ogpt_env/db_nonusers/:/workspace/db_nonusers \
#   -v ./_h2ogpt_env/db_dir_UserData/:/workspace/db_dir_UserData \
#    -v ./model_collection/hub/:/workspace/.cache/huggingface/hub \
#  -v ./model_collection/torch/:/workspace/.cache/torch \
#        -v ./model_collection/:/workspace/model_collection \
# --gpus=all --ulimit memlock=-1:-1 --shm-size=4g \
# --entrypoint=/bin/bash \
# h2ogpt
