Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696AB17590
	for <bridge@lists.linux.dev>; Fri,  2 Feb 2024 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857794; cv=none; b=tvhgdsIrBYt3p3goKViTkOKSCqeHdNxOK9x6UwVMzBmJ7IGJVLbaF0oT1PUZUs7rJ83W4h3UNr4vkGtwHb3MqtLSKNlkw2TavLlReNrQjD9UA1Mu7QAQX1pvTukwILpjAoPUAwHD7o92oRZU4OCXuFiNoVHEKEXnBZONNWcDf1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857794; c=relaxed/simple;
	bh=aM0I27fSxG9ncsoOwq8+RLtJ8Akzqu2IpCqFvquszZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R+eTOcf4QZTktzhQrgRdys5uagFyc61adr2rC29qZ99bufjncElLLVJbBWS5eQAkKKvskdXC4a8oOAAd/mxdWjMpDTU84j6QWQQ1kzPL4wrDBE0PmzKckolYXvmSSRwWKTGw2Q0lIvllJlex5kzHOYD+S8ZfU0mhgc2g8BO9z+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=j+RzilU1; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="j+RzilU1"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eac018059so2193273e87.0
        for <bridge@lists.linux.dev>; Thu, 01 Feb 2024 23:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706857789; x=1707462589; darn=lists.linux.dev;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o0xl4+XqIugVEwtcY8bcqC8nTrvfpuE9sxWYNsaFq/A=;
        b=j+RzilU1eL2nQG3x1HL/6tZgFIu51f/QZvp6UkqHAFIHHaWPHyL8aHh+E2SUyVb0Wd
         wNChx2bcotiXQeVkmp7ywJcRxBUvKZCE1Dg8AWPG1+i+2W4HYaLquFI2jBRCEUTf8l7A
         b0ytEa6KAe1NMyoL9QuSd5OrIb7ee3FeGfHLBbw9t1BE9GkDNPilaNoaCVUx0lG1Eh8H
         T9JnO1nmKFxzvZijtYmnqHjkqIF8XfQ8F9FqL5dpWtWnFZ5DCAbZ1SXl2rDXHdHMQkJf
         qkXw+bBtE+MQHyy+we3m2hbQi+IN2qzT43cqvS+Vsvrai2EAjmVwIF0jF4Oy28OvcbjY
         NP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706857789; x=1707462589;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0xl4+XqIugVEwtcY8bcqC8nTrvfpuE9sxWYNsaFq/A=;
        b=beFqMUCG00X6vArp2+FSryGJodcpEP784zZbVC7Vi+uvDa8762dS77dQCwSUs8KBFO
         8w2q4sY1auZsh1Ab5pzFvvnE0Zw17CZjGpDFcuO2SSxs3Ydcg6pnZJWVQWszEagpEF+F
         nuxdVab3r/9dnYT6ufjNKwtXqhgPzMCrPezfk3WDCK673xEnaKKxc5pA4EeN+aDcBZt8
         Iw0RjnmSOvPWs1a1Jn35FURS7jNmYPuBzDjKro7SuNFm+311g50YmWQ5WGKfV61virnP
         RfqVGKZ45yXgtpDwJjotgTGyuxZppx4KAzaGJh84N3UpoMjoUZKja7bSUovtJLVpZfnD
         j/DQ==
X-Gm-Message-State: AOJu0YyG9WwZi+KMNRbcUYi63QMN9clU+9jhatl869z4qYCGBBEbIWEe
	iZIa2lCtc94shl7ikWgX6pAVEMpZurjMF0KOqE4feeyCZxHaLkOPbKHTghUe1V8=
X-Google-Smtp-Source: AGHT+IHBrRXbjJRB+j0ms4uycbW4rA/CKq+L9eqPj4WvKyB6UQPVnsq0i+wC8O2Sd5Jl/r8nXNQglg==
X-Received: by 2002:ac2:4542:0:b0:50e:1870:1ef4 with SMTP id j2-20020ac24542000000b0050e18701ef4mr601401lfm.48.1706857789212;
        Thu, 01 Feb 2024 23:09:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWfU6Hxs3SQwI/O6LS5fYegHC2xgnfAhMJL5Wg7Fel7Xbx1AvMT0xyuyGIeUTttCKZzUJwavB8Ph4IZs8DwJGqHg1V+iJprkUz/jjMXOxYAtJQ7ABPtOBDS+IWALSIgL0x/kRPPYBp9qRyAeLqGvPyMNhZKQp0kCk7gjF34S4nqkI3y9rn509f3bLjc/4dmMYxqMLcgYNk/jVNRKMLspbIn3vnudhsOY53WhkxwWzZOhRrdFT8huEZlvkg2x3GkO2Y0h7BXhnpvLjsmnZj+FYQXGA==
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id u18-20020ac243d2000000b005101b937bedsm209068lfl.5.2024.02.01.23.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 23:09:48 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, kuba@kernel.org, olteanv@gmail.com,
 atenart@kernel.org, roopa@nvidia.com, razor@blackwall.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org, ivecera@redhat.com
Subject: Re: [PATCH v3 net] net: bridge: switchdev: Skip MDB replays of
 pending events
In-Reply-To: <ZbvFwVSQI1M_2WZo@nanopsycho>
References: <20240201161045.1956074-1-tobias@waldekranz.com>
 <ZbvFwVSQI1M_2WZo@nanopsycho>
Date: Fri, 02 Feb 2024 08:09:46 +0100
Message-ID: <875xz7tk91.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On tor, feb 01, 2024 at 17:24, Jiri Pirko <jiri@resnulli.us> wrote:
> Thu, Feb 01, 2024 at 05:10:45PM CET, tobias@waldekranz.com wrote:
>>Before this change, generation of the list of events MDB to replay
>>would race against the IGMP/MLD snooping logic, which could concurrently
>>enqueue events to the switchdev deferred queue, leading to duplicate
>>events being sent to drivers. As a consequence of this, drivers which
>>reference count memberships (at least DSA), would be left with orphan
>>groups in their hardware database when the bridge was destroyed.
>>
>>Avoid this by grabbing the write-side lock of the MDB while generating
>>the replay list, making sure that no deferred version of a replay
>>event is already enqueued to the switchdev deferred queue, before
>>adding it to the replay list.
>>
>>An easy way to reproduce this issue, on an mv88e6xxx system, was to
>>create a snooping bridge, and immediately add a port to it:
>>
>>    root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snooping 1 && \
>>    > ip link set dev x3 up master br0
>>    root@infix-06-0b-00:~$ ip link del dev br0
>>    root@infix-06-0b-00:~$ mvls atu
>>    ADDRESS             FID  STATE      Q  F  0  1  2  3  4  5  6  7  8  9  a
>>    DEV:0 Marvell 88E6393X
>>    33:33:00:00:00:6a     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
>>    33:33:ff:87:e4:3f     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
>>    ff:ff:ff:ff:ff:ff     1  static     -  -  0  1  2  3  4  5  6  7  8  9  a
>>    root@infix-06-0b-00:~$
>>
>>The two IPv6 groups remain in the hardware database because the
>>port (x3) is notified of the host's membership twice: once via the
>>original event and once via a replay. Since only a single delete
>>notification is sent, the count remains at 1 when the bridge is
>>destroyed.
>>
>>Fixes: 4f2673b3a2b6 ("net: bridge: add helper to replay port and host-joined mdb entries")
>>Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>
> Could you please maintain 24 hours period between sending another patch
> version?
>
> https://www.kernel.org/doc/html/v6.7/process/maintainer-netdev.html#tl-dr

Sorry, I will avoid that going forward.
