Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7C284039
	for <bridge@lists.linux-foundation.org>; Mon, 16 Jun 2025 02:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750040749; cv=none; b=RP78py2FVgyJtbhlI5cK0j+EkC2r/wpWq3karn7a8C5E5hoTnkYHkH/3NV0hpgz7aFaFhssgwD1XolT/zqXrj+BmdJ2wl/tOsoZ6sakuGVppRq9xI1nBj33WgXyQ++oEzukLTODOcdRWGx738+KXCjndzWZr/nzUq5XEPbSKvFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750040749; c=relaxed/simple;
	bh=yeFyrQM5AEph3nqocW9/s3/siGve0QTTes0vDmiTWpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQNsr/ihqvaHyZ/jvpcd8zKvC/xeh9Wab4WG2uUr2pkYCD2KUtcM6kAcdVk5uZFhSXpgULb7jNxpUvMmIUjATttfGwUA6xyy0w+ML468Ln++t62iqbe6pyjJrA71ydYlxySoyRjQ05PXsaDjkXGICODGCK1zM/oIRHuMamr2uBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkNivQeL; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkNivQeL"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBC3A40491
	for <bridge@lists.linux-foundation.org>; Mon, 16 Jun 2025 02:25:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T7aP-9FLrOao for <bridge@lists.linux-foundation.org>;
 Mon, 16 Jun 2025 02:25:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::130; helo=mail-il1-x130.google.com; envelope-from=dsahern@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 26CB240480
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 26CB240480
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FkNivQeL
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 26CB240480
	for <bridge@lists.linux-foundation.org>; Mon, 16 Jun 2025 02:25:46 +0000 (UTC)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3ddda0a8ba2so41711925ab.0
        for <bridge@lists.linux-foundation.org>; Sun, 15 Jun 2025 19:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750040746; x=1750645546; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BgTgVNhQF2E1TeVy3ZkzaWAE3nckokq6BK2WDQTXKws=;
        b=FkNivQeLxyPBySH2J0BiYS5JxwNBLWzYCXsV2BhlvtJ+9hdevbyujiFnQ35hpJSJ75
         AMSH2D1ThJ3LslRlPNXQ5lEQ/R1sANT3WkZF/tbkGwhNZ43/7oDoUuUVAMs2+TqGfJBZ
         WOh86hTcg9fgN+LKyVH0liT5EmfK3Z9XGpFwrNBlmNRPB131BvXGMEHSfszgm+8FMHNP
         n7MoxeoHkE+VPCvZU4wlVHqhRVWsPFQC9PPWky+u5m18CeYSEcTumewJe5l8YxM2yf3l
         kVzWtCO3O9wLE29+sCUU7t6AdhowfNW2rne3SHnvfRvSEMX5CjCqt8jhflohK093dZKt
         iJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750040746; x=1750645546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BgTgVNhQF2E1TeVy3ZkzaWAE3nckokq6BK2WDQTXKws=;
        b=P+b3LCIRlcF/NG1tCAQEy+QDkN1kKaUpDJQ23EyhK4se09KkifWfep73hBfv/clJjX
         aG7GRthekzo9T/8sbmXX92bSaHv7tHSUZwxLwH2sDvG+dgsxddAJGhOiR2qfwrf88dpT
         LF/H/Bm3gdfzf4yOOCJ5UToRPoQqIA61F932i6Vi3hEt+9h2JNQ8eqS7w9ZxYLdNnOml
         Jdajm7B7kqv6LQt9qoIpdopz9LyJxPI/nqXkrTiL+VX/7WPbn5VOMdCJ17QDw/2LHxBp
         +p08WUpemv87IiYYb/ZQIKh41FMtT5oquj+vyB8/eE86ffBNbwV/DJzi8NVaKcUPoUo6
         LYXw==
X-Forwarded-Encrypted: i=1; AJvYcCXFA1UY4wq/rLaWCy+bytqsgbB+WZmYhhJF6Hwu2scvbiMnctb5gK7+UPx3ZaNaMdAz48eYkaw=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyA47CNZfEWVhPzfttI3qUodLfibb7FYo14oqarCwD2z141rS38
	mq+OFZeRMwv/RnpxIAMBgGjUgyjeArxX9Dheopg54di2KPP/ceU+h3OY
X-Gm-Gg: ASbGncv5KwBqOWFfOAMMtXBfZsY9dz3Uk07a3VAFT4XuIXfv5D/mCBpsIxVBVmjC/Jk
	QXf/jDab0LD6YJIy86ekluByvxgwsAMUgLPQBogtKBcd5gVUgRmB3t6vD9eb+NEaUnvCMsOqqSX
	9IGv4LUxtppQCdzfUboSqRQaeYK5S34ZPOksiHb9X26fXKojefy2jLkn+k6JR73jwGL+gth8o88
	rGnL/nvg+dqwM1PtXHo6RfPMp8K9wHOyH4n1hOkhOzD9HZESxVG/RYEhUYFpm2G9pxlL4ODeuMV
	tNpkdV8N0A7j3oOaPjqUHTw1oL5hc9nJS8zGVvZ9msekY585k5Hi+lCnKLRjMYKhTpeQEIz5Vpj
	1M7ATgyXTrjFPdsFdZzdSa9HkWhHGJRBBlYhvmOGtGtTPOt9I2DQjBw==
X-Google-Smtp-Source: AGHT+IGesun+N2Fm0W/s40zUYMzKgBFnhl5xqVFUClZW1BUYLIvQHYcLL4mYPtHcTXUmtHHTDYEoSg==
X-Received: by 2002:a05:6e02:1a8c:b0:3dd:9a7e:13f4 with SMTP id e9e14a558f8ab-3de07c50279mr90766025ab.6.1750040745920;
        Sun, 15 Jun 2025 19:25:45 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:7db2:1a95:a8bb:562c? ([2601:282:1e02:1040:7db2:1a95:a8bb:562c])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-50149b9df11sm1531147173.54.2025.06.15.19.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jun 2025 19:25:45 -0700 (PDT)
Message-ID: <d38ab6ee-cafe-4981-9e01-19c7b5525847@gmail.com>
Date: Sun, 15 Jun 2025 20:25:44 -0600
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v3 0/4] ip: Support bridge VLAN stats in `ip
 stats'
To: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org
References: <cover.1749567243.git.petrm@nvidia.com>
Content-Language: en-US
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <cover.1749567243.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/25 9:51 AM, Petr Machata wrote:
> ip stats displays bridge-related multicast and STP stats, but not VLAN
> stats. There is code for requesting, decoding and formatting these stats
> accessible through `bridge -s vlan', but the `ip stats' suite lacks it. In
> this patchset, extract the `bridge vlan' code to a generally accessible
> place and extend `ip stats' to use it.
> 

applied to iproute2-next. Thanks

