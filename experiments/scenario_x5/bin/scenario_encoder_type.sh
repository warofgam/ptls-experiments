# LSTM encoder
export SC_SUFFIX="encoder_lstm"
python -m ptls.pl_train_module \
    logger_name=${SC_SUFFIX} \
    params.rnn.type="lstm" \
    model_path="../../artifacts/scenario_x5/mles__$SC_SUFFIX.p" \
    --conf conf/mles_params.hocon
python -m ptls.pl_inference \
    model_path="../../artifacts/scenario_x5/mles__$SC_SUFFIX.p" \
    output.path="data/emb_mles__$SC_SUFFIX" \
    --conf conf/mles_params.hocon

# Transformer encoder
export SC_SUFFIX="encoder_transf"
python -m ptls.pl_train_module \
    logger_name=${SC_SUFFIX} \
    params.model_type="transf" \
    model_path="../../artifacts/scenario_x5/mles__$SC_SUFFIX.p" \
    --conf conf/mles_params.hocon
python -m ptls.pl_inference \
    model_path="../../artifacts/scenario_x5/mles__$SC_SUFFIX.p" \
    output.path="data/emb_mles__$SC_SUFFIX" \
    --conf conf/mles_params.hocon

# Compare
rm results/scenario_x5__encoder_types.txt
# rm -r conf/embeddings_validation.work/
python -m embeddings_validation \
    --conf conf/embeddings_validation_short.hocon --workers 10 --total_cpu_count 20 \
    --conf_extra \
      'report_file: "../results/scenario_x5__encoder_types.txt",
      auto_features: ["../data/emb_mles__encoder_*.pickle"]'
