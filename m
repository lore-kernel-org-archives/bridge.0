Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5619D4409
	for <bridge@lists.linux.dev>; Sat,  4 Jan 2025 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735983355; cv=none; b=lbplmRzPwIlIvaLmHhY4A1dj7/T92mN7lW/dRwu5Ce5P677fWd9P5uUSViKcLKvfs0lEhcg4W0MYJtrD+rvrkqvs6l7LTY2B0saLxIaye+uK5lRFGslCuIqHnetkktq196c1oJWFmN0uIV7Z8DPHlTv/QNb8D2TxxRRG1VznNEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735983355; c=relaxed/simple;
	bh=LfX77oNgqbSpo8Uz4zxGDRt/7OcCsIQLS3BUiJYao4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aY1zJHShA59FQwFG8KGLcttDs4LX8RjvXGwIeV2SUgwGllOxy2/07E4M5F18dajGQxXDG4kxap/w0fZAcShbWNpAziqJQ5daViGiuXJiqvXlFWXg5bxY1+dP8gLZSHbADpy0eSydOLc7Tvk/aZAx5s7XlF5zQooyC4h11n7eaxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=RU94qdY4; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="RU94qdY4"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso22442033a12.2
        for <bridge@lists.linux.dev>; Sat, 04 Jan 2025 01:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1735983351; x=1736588151; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JIRtfYLc4NOlF7KrTibQZLCMnpb9G2HjHDpKPsmPA0=;
        b=RU94qdY47q9NgWfWhBsraY/ypLIWnvRo+oaNuklVjQx9g6qcayGXK0vsWbr7/S1tI5
         b7vNboCCPCXqboQaQmK/4DZgGydjhtP2xVIA9teIkF0+LZ9KzS+R3CKC48ylr7Cbi/KC
         e4gW4hOLadkeKkiPX95bAufeKSlqXelYqmyIAVfXa7ohdZn1+7UhdP3/G+w4sv/659RU
         WwfNlsi+yIEvp4rgUep7cGRIEtCpFr8X+5B2GptX//6cBHtuDSmgejW3hKZZj8eK8ScH
         qAIxhzfPWpUI7UjMtaW764OaeLhX5vRAps+sDQIUZiQmwOVJu/gIHJSwToV9vAWjkVs2
         9Y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735983351; x=1736588151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JIRtfYLc4NOlF7KrTibQZLCMnpb9G2HjHDpKPsmPA0=;
        b=g+q857Y6g10hQ1cy4GB3NMbTM2tB9f/3BIAuq+zoAxceryAIwzMF1ZHmAOEXYukmrn
         33bkqMZuCAfHmXlQ/vupwTuAuJTJlIUPok1gCcEuXgvsc3sd6RJDpiO5kyt81IAbsPc4
         iFMBydiOJIQc9c6G8zn0mt+ikCTtYFRvA/MXeDWgrQmo8Z3vEOmycdQtV1nKEc/iG3+/
         JTdrptJaCGXz6o+0tOFHZbrqNLn6zg0ReIWLXCwdvpOAe7eJT7zQrxCP78DimrFhsLkj
         gG7xOta1om/wB/HnDCrjuriibS59JzJuAkgUZeiNUTkvHuTGTTJ/+2Z+P0RrsYtfAtRX
         +vLw==
X-Gm-Message-State: AOJu0Yz9IFi3fbxQjp08oSv5ygn4nW5Z/FrPD/Lbj14wbY1E0GOtu39P
	BJ5Dfh9HIwTLCnCoiglhU/KqEs/OvfSnXSyhuieqJluBO2msYG//4FVWmsWdUgo=
X-Gm-Gg: ASbGncsVZEjtK0wZwC9e0BA7jw4T+lylmiQsFai7kHct6A+w2B2N7kW12uUagcGOvo4
	TrQFkJlhK4V6yHbgeWmnycPLPpabg8RvekjmS4YLrVcR9tWM7giMTLnrIFUpkYw1Os4tzgIcl5o
	tbGUcH9jIkJjxJHJm0WO4bmscnfNMahJ9dd3gcQaPu+s+Leqc/Lz4UvqMf3/SoaXKES2VoqYF6l
	D0KHZqcm4DhXLlqGp+yjvVN9JacZ8sHGtyOHGgYFkVxVC8nUqml8KC3AZ8C0Jpwi7Vwz5tV2ZsQ
	2RUbtNKNk7Ut
X-Google-Smtp-Source: AGHT+IGqCinoycrbLVXIp1NEc60NTfZie51dGnaZMUm0mhrMIwLb3OmF2OfNiuQXwoa0JTUHX4Djpg==
X-Received: by 2002:a05:6402:540a:b0:5d1:f009:9266 with SMTP id 4fb4d7f45d1cf-5d81ddd6d22mr48235020a12.2.1735983351472;
        Sat, 04 Jan 2025 01:35:51 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a5a8sm20395053a12.13.2025.01.04.01.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 01:35:51 -0800 (PST)
Message-ID: <5237f91a-bfbb-41c5-acd8-03ac26052e50@blackwall.org>
Date: Sat, 4 Jan 2025 11:35:49 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] bridge: Make br_is_nd_neigh_msg() accept
 pointer to "const struct sk_buff"
To: Ted Chen <znscnchen@gmail.com>, roopa@nvidia.com
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org
References: <20250104083846.71612-1-znscnchen@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250104083846.71612-1-znscnchen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/4/25 10:38, Ted Chen wrote:
> The skb_buff struct in br_is_nd_neigh_msg() is never modified. Mark it as
> const.
> 
> Signed-off-by: Ted Chen <znscnchen@gmail.com>
> ---
> v2:
> - Rebased to net-next (Nicolay)
> - Wrapped commit message lines to be within 75 characters. (Nicolay)
> - Added net-next to patch subject. (Nicolay)
> 
> v1:
> https://lore.kernel.org/all/20250103070900.70014-1-znscnchen@gmail.com
> ---

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

