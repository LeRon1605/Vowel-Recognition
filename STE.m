function ste = STE(x, n_frame, frameSize)
    ste = zeros(n_frame, 1);
    for i = 1:n_frame
        ste(i) = sum(abs(x((i - 1) * frameSize + 1:i * frameSize).^2));
    end
end