Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF09544213A
	for <bridge@lists.linux.dev>; Fri,  2 Oct 2026 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971202; cv=none; b=jC7k8uz7nZbIPzWMGlleDKxynUirjxRNPLHilu1TvcamfhLiJXfFNbOTMQ42QAIVHjwaO+YV8zgwmsNZYJctZvXg3+8h/dTNNJdWkxM0PVANYCl1kT1Xsif+vmBGG8v1V/quQElsKLGmI0OYnBptfENMJgI+M51CF2BUhOgEmN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971202; c=relaxed/simple;
	bh=bdiQLzVnx2a+F/wPqBLr4YiITMZ5yz7T1A6LJ/0pfnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCFckjWNb5v/GyGMQ40mJp2ThyURWkEmblnB8xk8cBb+b5EcHX5UloLp7VQ8eoGlG04crf1PNeCk6J7faV2/7rXoV3G6VYbY2evcLvgGFy7+Nj1HIak/Rtwr/rZ0+LurOTuFEVztrmfoYQ8wpFp7eileb0TB69dUqwQU7NwCCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=lm8PkkCC; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="lm8PkkCC"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso1294985e9.2
        for <bridge@lists.linux.dev>; Fri, 02 Oct 2026 13:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790971199; x=1791575999; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tdi1g/9HctPzl2xgKw5LeRr2kShiiRFjAD27/Ur/UmA=;
        b=lm8PkkCCnnIP1YWn7rQUV/QY824BgO4IyTG5FR/mO0tB6O8drjb1TsxZOY3x9NZXLJ
         qyxqk1pT0O1mIq1ZTskuVUIU112NAZyskYhG/ljzuMtziOmRE2z5EKXwloHFAA4SmpQk
         MNlDUs/t7xB4uc9SRvJ9m0MumHqOSAWJ6JQwjx+jdFVNlNRtOd4XYcqi0sx0S6+DihqN
         q/5WoNkISydNVOOhKfZ4d47PO7C7LfDK+YKBJMBdM4rQvOdFXRdgu8XjtD8ZKGiIxcNZ
         vxmBu/A3s8VXtOFkMmkxChOPwqPEOQaerr1dFYCcHTlgxrMGrGgd3FsG9hBhk4kjJ8HA
         hQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790971199; x=1791575999;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tdi1g/9HctPzl2xgKw5LeRr2kShiiRFjAD27/Ur/UmA=;
        b=2YC6JOgHFB+8EcAXYHOw4zxQuvBrBf3iW7r2vF7Jy7PJ8RtyTAiT6Y1KSHXiu8aKTX
         59QvLKOBjqL/jLx1YT/95VYgc1eV3AS/oRtUUCId8bcZlLpXl19cKN/gnjMDa3K6qiRW
         QZQqjRX0k/0I2k4farGcCrqLxAFtL7QDyBWRT8dtAHvBHSQlZntE+kksJuO58K0QhaMk
         Y076hdZ8iAIWcXzoIHwnqA57VJQsVWb4Mi3v57TydCKQy8U7GsbfQy3s1CGL8Wu3jkDd
         YY7Rma5ZPHpkem+J+SOFR7xXdlxvEU62WLy/nv8VXt/tJs902s7t8tFA8oohCxezF2Ow
         plEg==
X-Forwarded-Encrypted: i=1; AKwUvBxFhk3OnpUGIO4FaES6brYuImZ8KS7X5AHI//fCzLSAeuXPS+YBCYobKcziyAnKyvcA8PegA5k=@lists.linux.dev
X-Gm-Message-State: AFuF++lEKie0uZTQvXR9JpJB2W2oluGuydVcx5zdkz8EKyqbCYWoTKcc
	iNcUMsaPUdd/mOrYfJILWDjwx6qf16SggkhE0Fcq7Um+HpdN+2cJbuyNoRzF3zn14lM=
X-Gm-Gg: AYBFou0pgF6KslmULbefbm63idhGIFMLgc+RpPjTjQfPySzc50KH13WU9rDS92/m7WK
	0kZg05F88hFCYcRVK/0PHZvyXBFBQA/vcPDVYsH3MKOgcR8DPEkcJkROtVCxr5qVdOgBK1/9wHm
	//u39c/+jffw5mQajSaBFr0BvRR8tJ/0q3dd5CeOun0hM/f3t+x3uVwCb70Kh5N8lvjVlG0BEI7
	2PvEAT1mD5TceOnpy6CbRWzvuwFVx/jkw6oPdEtdH4gRR70P+ZPtVVoRTgCvFfOJRoP/fWh65Sx
	PMSTweFsuROcnjZ5Px9k4MGw4uwRo0vxmoUlInUgAkNvrZLY6hX09fjh+ZOdMKmV6vISLx6lHI5
	ywFm2TGvbDO84MNj1nIE33hU3Vhjv07zUjwNe1mh7Sfg1R3jNJnpFjumpZgs9aZ6wI5HV2OCiNO
	fiLobgaMxIKiXUyIm8QCirXXKlh39MJtjgA3+qCMEqYNqezOgN2UYBMLJlSd+MuCJNTfL8BawHU
	tMME/cL/IFtVuhJJFkvrgmKg/kElw==
X-Received: by 2002:a05:600c:548c:b0:4a0:1eb1:133b with SMTP id 5b1f17b1804b1-4a0275599aamr64108765e9.12.1790971198949;
        Fri, 02 Oct 2026 12:59:58 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a039505568sm92985945e9.3.2026.10.02.12.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 12:59:58 -0700 (PDT)
Message-ID: <29eac8d5-4b2a-4f34-8792-76eecaefa184@blackwall.org>
Date: Fri, 2 Oct 2026 22:59:57 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/12] net: bridge: vlan: quiesce readers before
 freeing port VLANs
Content-Language: en-US, bg
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, bridge@lists.linux.dev
References: <20260930071411.2786201-9-razor@blackwall.org>
 <179085595119.434549.4421493167752460988@kernel.org>
 <f529d8a9-a4ab-4398-8754-d6c7528133c7@blackwall.org>
 <20261002125005.15b6b56e@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261002125005.15b6b56e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/10/2026 22:50, Jakub Kicinski wrote:
> On Thu, 1 Oct 2026 15:07:21 +0300 Nikolay Aleksandrov wrote:
>> - Yes, they can be batched and I had them batched initially but when
>>    I ran my tests I didn't notice any problems deleting a full VLAN
>>    range. It took 79ms on my host to delete 4k VLANs. As I've stated in
>>    my cover letter - the complexity is not worth it, so I dropped that
>>    patch.
> 
> For the 79ms number - how big was the system and was it busy?

It was a VM with 3 vCPUs, not load. The baseline (without patches) was ~25% faster.
This is still a slow path and deleting 4k VLANs is not a common thing. :)

Note that flushing all VLANs usually happens when a port is being deleted and
that is still fast as before (it doesn't wait a gp for every VLAN).


