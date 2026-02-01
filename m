Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D6D284895
	for <bridge@lists.linux.dev>; Sun,  1 Feb 2026 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769934559; cv=none; b=b8KKENTbycc0j5p/VJiLJlFF3rwMWjLLf0X0sKLd7c3DxXlyCwHMDh3G5wqwI7EVpRvPxz+Ia0gc7WNFGYMRbTKOUGy0H7w5Uaq2Fi9zE/xowMhiSOEhgB/opfZz4O/sYzDP1iu2DPnHi+u5zDIzduFRI19lO5iu5iLT7BJDdJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769934559; c=relaxed/simple;
	bh=6JBUx5f0OtPOVTySvaqIgC/De4Hhkb8Gn7hMOdnqxxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhaP3x0kqxd8i5i/FeFwCB39B29JEconu49HUwSJQe68aMGryZ+VUOF7Ru6hgm90UdmWB0Ek/8yV/SCgp9ngsCW/8hRB9I5lKhRcurmcZaNDdYejYrX2W5rbwF5nGw0VD76Tew2Z5kIFmA9wt/PP5iCavrnNhA4Chb4MXJFqvvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=cK1aYoeC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="cK1aYoeC"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-480142406b3so24927645e9.1
        for <bridge@lists.linux.dev>; Sun, 01 Feb 2026 00:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1769934556; x=1770539356; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SeZOjfl31A9xEaccgdXksgXuAf1M1N9YkibI/QkCSYk=;
        b=cK1aYoeCPosWJ7PLRgUpDyNsT5W293hAMbFIo7JFI+aEjmUBqhfcmIMMTC39JuD44V
         KY17s8dVsWzgiZYal00DMfmCgVrRJ+UMgmOdaXg8FD25EPWjz0fBUTCeC0RYCzCLvXQ6
         6u0ryMNRtqEHE0kw1VbJ925a19Mi9Zip4aON6c49VinlVWojKRi2x8zo6Pihu0MIFgcC
         SODO2DiWx3itSvaVNRdI9Q99p7GpX2+xjWyT809q/R/HD9X0GDhBbS8UcEfKOy9PnZsm
         l6sydbdXHHzCW6p8B7CQpKGOumzlyRy/ybkE2u1h9il3FjZoiI+ta03PjYCWKqs4thns
         pjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769934556; x=1770539356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SeZOjfl31A9xEaccgdXksgXuAf1M1N9YkibI/QkCSYk=;
        b=DpWaiHVo7Mypvcgb1J8/GKiR3HUf4Y9tq23vkmgAmMBb+07BJvZzm7l1/KrRRhnGia
         hRhoZ1m1fs0U1cZTU8KYG7ivbuoobrGyKtgGLYRBXXmZdzq71MjKGYko090BhqjX/SLM
         maiRlAMraXA3gWX7N19fx5gB0eIlKUPODnwEUQ2ISHDxVRgPE6vOF33sJRnjxHuhdKrK
         AGZGW6xyMrzqPC7pveBqSncx/H3QXk7mNh2XMhObwpvytMGM/TJimBuuQjI8CthjVm6Y
         RiXN42SeT2OUrFOiOpDN0bOnDdB1l8UVtrQ7EDkMMCAZ9YEAWgeUwt6i38imPZkpTffp
         oYfA==
X-Forwarded-Encrypted: i=1; AJvYcCWJCGcBETXBOmSur0He3CU9J0uZ3hFxfWAGfr2v9yNfHyGoOTSZ6RLpDz0asTTsrCJZjixdadA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7UddqtoeIR0CoEMqZCt3MJ2NXztTUYlhNGcFckfgNwjtQiA0m
	LoIL7JgRlVCv4pNIHFTHWOxyuGcSgwgPq7cqaT7k4XOuHJDqbFk6aBFviVDokvHvgkk=
X-Gm-Gg: AZuq6aIBHtXnDgHIgEBGgwNQ58Jpev3iyo3tuJSTZQQ7kNlg8C7PxDRV0lbEF7EiKdW
	1s2FXMEXLdA+4hRUT/t+yfhbMSE6HZzQhfwLqWsN6GjR3oC08+NiS5C68Q6oshbVAOdztGA0YkE
	OmBqFPNQRsxrAKOtzigaS49e4HAkg7bejB1BMGywWhPKzeyHFqllYjcXmj2+vWKsZJAomu+r/qK
	qdeqhkQnw1Lt3diy3NuOtDOBlFEUtMPUfaupE8hnUOIKkD1USiUb1L69/x95RW1FofI5M69MSis
	IBGR4Or71JKDY8T4HqkIDg+Doq5fVJOZN4cvEz1yLdyQkstkLKoWRA7twMnspPPEO+5CiDGkIv5
	IMEeE4/zdCj2vzZuGhgjaL/UEjWJkR8ZmG0/PG+JH0M7QrS+65mgVoIiuzCdliHInbacIvCPspX
	1OFZ+sf5E34ErLS/bvEVa50rmzRLGXAbHZCbhBs75ZSA==
X-Received: by 2002:a05:600c:5288:b0:480:4d37:e742 with SMTP id 5b1f17b1804b1-482db451e66mr97897665e9.10.1769934555855;
        Sun, 01 Feb 2026 00:29:15 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322dc7sm35418959f8f.37.2026.02.01.00.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 00:29:15 -0800 (PST)
Message-ID: <076bd8aa-e06c-4b0f-a659-d35de0319b55@blackwall.org>
Date: Sun, 1 Feb 2026 10:29:14 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bridge: use sysfs_emit instead of sprintf
To: David Corvaglia <david@corvaglia.dev>, idosch@nvidia.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0100019c14f90490-950ddd9b-1897-4111-bddd-0d4b8abf380a-000000@email.amazonses.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <0100019c14f90490-950ddd9b-1897-4111-bddd-0d4b8abf380a-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/01/2026 18:53, David Corvaglia wrote:
> Replace sprintf with sysfs_emit in sysfs show() methods as outlined in
> Documentation/filesystems/sysfs.rst. sysfs_emit is preferred to sprintf
> in sysfs show() methods as it is safer with buffer handling.
> 
> Signed-off-by: David Corvaglia <david@corvaglia.dev>
> ---
> This is my first patch to the kernel! I've been able to build and boot
> with the patch. I also tested the sysfs reads and they seem to be
> correct. Any feedback is appreciated.
> 
>   net/bridge/br_stp_if.c   |  2 +-
>   net/bridge/br_sysfs_br.c | 84 ++++++++++++++++++++--------------------
>   net/bridge/br_sysfs_if.c | 32 +++++++--------
>   3 files changed, 59 insertions(+), 59 deletions(-)
> 

Hi,
IIUC it is safer because it takes into account the provided buffer's size (PAGE_SIZE).
I'm saying it for the curious as  I only found in Documentation/filesystems/sysfs.rst:
"- New implementations of show() methods should only use sysfs_emit() or
   sysfs_emit_at() when formatting the value to be returned to user space."

Which does say "new implementations", also most of these are numbers
and cannot really fill the provided buffer, there is one instance of a string
but it is an interface name, so that is limited as well.

That being said, I'm ok with switching to sysfs_emit() and the patch looks good
to me so:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Thanks,
  Nik

