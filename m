Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997202;
	b=RzFgdxWZCJAxODOQZDLOzyjTVhjXkKbiZvFKpZTzd18N+DgcYLZyVUgZAqVCEwbD+gQq
	 8sDekWRbARccSfnJi/eXqICr9mohyrg/nj2/9asZB4l3N/11hJtF/SKzQLFjo+hkEchqx
	 wbox6FOTuj+i2c51mH69bczplYHBYTwngY9VEFHB2iOigO6c5f46ayEvDgtpymn8jhpii
	 rRF77aSr+/BUIvhfQQoZoxeUo6hy0x1OovqoErxFYJjZR/O4b432bmebcii5kKuAALwlp
	 h3vLgUk9Tj12nHLgiIi6pP4woi3FvMUrnS9rXwcmiJFTGqCoPJ65ekYg4aE2BNC01aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PSOjBgBm8MEjVeDHiZJ2TYhPPf+RsH0/cDY1a5KM/5A=;
	b=YPLh4fJntt9hl2qXWbGjBObOvaXg3o+Jow3z81mYjixrk/8B1F876z1xG1ONv7gllGFz
	 n6JhODroJgTlnWXRNFrjqu/A6laWJxkz2jVsYNbZ/9QbPHRkbfWE1o4Oj/PE6SVs/DS6T
	 8/SDqwb9/E2pwNuCaJHSKTTWUO/uj4pKkod2YHtv1QM7q+pnvhXhPp36X8D4Uh64zqsJD
	 7LgxbQEcm+tWbfA4B2GPVY7a0537xRpH0jrjynFG10XJIiLeqzGLN/Cafvd3ZwnOLV6c3
	 duEjoeXofYkZrS2/gC31C9GLpD6q/yzQea8dIIbsljbuWNo/LRqX1sqs2JenWx1y/qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NSNL7KnU;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8C6606A325
	for <bridge@lists.linux.dev>; Wed, 18 Nov 2026 10:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B8C6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NSNL7KnU
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso363561f8f.1
        for <bridge@lists.linux.dev>; Wed, 18 Nov 2026 02:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794997199; x=1795601999; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PSOjBgBm8MEjVeDHiZJ2TYhPPf+RsH0/cDY1a5KM/5A=;
        b=NSNL7KnUadeEDKPTOIhdh5EF3Sp5onQKdaxDcvk2DFstip4FJoxbQXSCxprebf0F+A
         QxiWEIepvcVKUbMFWen/dQeNScp5XRXgVeQMYsLwAa/JFJVSTMWfLbXhNnRM0u8uC60h
         yn6y3+ORfTPg58DPQEmv4po9nzDrPeW+k6WRdN2KQlhh5r4qeoWRqaT1NwwDGDbfGQjP
         V0fiP8wgRFY6QhV5XPuPWSeRN/hBSEOp+69Jf0NcF/eb0hDYpp2I6loj5dyK9dZgHl07
         ZAbF9O28QV8Jdm2dj1Adpzh/3X4F3k98p5BseFz/B6do7poOKkQOCEbIpu6+/uHROfu6
         Ah0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794997199; x=1795601999;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PSOjBgBm8MEjVeDHiZJ2TYhPPf+RsH0/cDY1a5KM/5A=;
        b=EksbtgNE+aS73Ymo9/Iqa8YQkjUJpkajpTbghnb/gw294R7jygCo5wQy5yt8W/DvFV
         kyzY7JKZw3o/eJSL5SP9CaX0MbBwxHK/CDxRlP6Iv9XgriKJ2OBErh/64v6QGYQTKy6G
         J8VqPAFV1t8C7iM4KAFPbnUj7qM9ZSrHUEbmAn3SO8yxvBzftnN8ukakfbx9LyOCRcr1
         IDMIyBY/sZeiyWP1SMpzc4s612WfkQxpmIAaqH7xJkV3b+BiGNfF9IulcISGX/tnKfrX
         LXSknXzi/x8Z0jaS7N3Hw3K3CvaRgFg6gT/Ae6+XmdpdjALJvwzD7Zuy4biXBHviPHVI
         bZJg==
X-Forwarded-Encrypted: i=1; AL+hErFQZwsIoACJPbr1CW8qUnBR+L0cRvodsvMZJ/RpzIh1eboigmE19+dtyjPZFoz1sm3jae3TOaY=@lists.linux.dev
X-Gm-Message-State: APuU4Z/6xCV+Qf1gl66V3OrOnz0yurr0r4y/fsyJv1xFf3M71iSdVod+
	8RByZjb1xUiPsdC1BjDmZzszBp7/BFibqsQuOWZ4z+ZXvNUXlCuw3Dnp
X-Gm-Gg: AYBFou3JGseemrKOvNE7E4ONEkBcetxelwf9vzDr//PQP5rWvCoa+viU+idVFoGkube
	iRsHLvLgI/c5d0Tl0z9sQ0+YMGK2cgmq2ICPAQlsJ7PhwpbDXI93J3dERDcYUuFTlqnpMQlPi0n
	ReeLy7I1/WE9tJ+yf4kMHhjF3//AY+nmXNG8wqWdmMeNrUa0D/jkKxnH4wsqg8B7Jhm6e2VdXQD
	2dKVV6h5cVDiz21bAhVvGVgJbOjShecYOAYDCwUlL+Q2+Cr7vleWnX2RqwkLO1PfL+u2emJp/SF
	8ldqiGX5mv6yXJDoBUT5s7kfbtZTIWh5gaS6GfVowrxFiLnvVsAKDHhKFLgRgDGreISx/FioikK
	E8Svd1Z7vJbPHpp/EeQ73o+zjod0+lP9Ww/WfNIWy2OIHng5yschD1/UJxc8ojljfNJVp2gmw7U
	Ai46PDeAY6hqOBlJ6qGYhfK07IBIEsAhL9MAfthxM4hEiB8j91piADtSiblxLIfsbF2pM0XF3k9
	DRv5vfVi4+V9ka1vi4M+9SRbRLau76qR+rflhvcPgSLhXchQ9vZOBb1rqvcohX3o6sE4DNP7MiO
	WtP/g4B93ATnjmg3aaF93Y3+B9YBJ2RSNZFh1A/KQbnAFLUE82CHHYSYqBaVRuxCKw==
X-Received: by 2002:a05:600c:4e45:b0:4ba:38a9:85e3 with SMTP id 5b1f17b1804b1-4bb7da127ccmr35383495e9.12.1794997199431;
        Wed, 18 Nov 2026 02:19:59 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d29c7b7sm44275345e9.5.2026.11.18.02.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:19:59 -0800 (PST)
Date: Wed, 18 Nov 2026 10:19:57 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, bridge@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] net: bridge: avoid redundant strlen() in
 show_backup_port()
Message-ID: <20261118101957.29ffcfd6@pumpkin>
In-Reply-To: <20261117165106.635733-1-dmantipov@yandex.ru>
References: <20261117165106.635733-1-dmantipov@yandex.ru>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 19:51:06 +0300
Dmitry Antipov <dmantipov@yandex.ru> wrote:

> In store_backup_port(), prefer strchrnul() over strchr() to
> avoid redundant call to strlen().

For most architectures I think the compiler optimises that strlen()
to a check of buf[0].
So you don't get the function call at all.

David

> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  net/bridge/br_sysfs_if.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
> index 621d62a063d9..03205b3f465f 100644
> --- a/net/bridge/br_sysfs_if.c
> +++ b/net/bridge/br_sysfs_if.c
> @@ -231,12 +231,12 @@ static ssize_t show_backup_port(struct net_bridge_port *p, char *buf)
>  static int store_backup_port(struct net_bridge_port *p, char *buf)
>  {
>  	struct net_device *backup_dev = NULL;
> -	char *nl = strchr(buf, '\n');
> +	char *nl = strchrnul(buf, '\n');
>  
> -	if (nl)
> +	if (*nl != '\0')
>  		*nl = '\0';
>  
> -	if (strlen(buf) > 0) {
> +	if (nl - buf > 0) {
>  		backup_dev = __dev_get_by_name(dev_net(p->dev), buf);
>  		if (!backup_dev)
>  			return -ENOENT;

