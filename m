Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500C01BDD9
	for <bridge@lists.linux.dev>; Tue,  6 Feb 2024 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256704; cv=none; b=uEeECCUBkKDkqd6mhBHFckM7AN/mHJcPt6rG0NoM6IKWALLWYSjvA8ociJFGWUQHJzUEJVeQpkIK0KB0o2fOZwHQsj+UB/vMOTTFDMEnoWN0/42Frh/0aUCu0vsPQZB8zTc9BnOiKgBaRGGcR4nn0cIO3gxdhv+7XMQnq8hIQQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256704; c=relaxed/simple;
	bh=qXOY9GbyPZbALlw6ohTUWTlO4N2Ho7SwYMoN+axyaXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PkW7s6g0+u4a2QjGCyrxlirTv3KqS/7GasO8a6uLTty1OkGNyIy/tT8d/AIwsv5UHWbj3yEf11syrHBPDzzV0vJIj2qm9qBtoYcsUZvU0yFbSrRwOTvFH22dOFHMuWLGGgUdcTo6Ao3POMfMWW6fxPM2DU6LzfXEOV7gGdT1uao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=YgtBiQPy; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="YgtBiQPy"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5115744dfe5so2110292e87.2
        for <bridge@lists.linux.dev>; Tue, 06 Feb 2024 13:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1707256700; x=1707861500; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXOY9GbyPZbALlw6ohTUWTlO4N2Ho7SwYMoN+axyaXU=;
        b=YgtBiQPy/gkmkEq2AJJdu1Bz4XN+phukzpO4do/FTBykl2bI3FtLgSgLrSVN+3XWeo
         u+sTH4ijHW8jkS+tGLbVHtHMC8LHsxYJNSWyvKaMFu+73p2mzC+IwIhVOPsD9J9BzqPm
         EL++HtbdZAK7zlw6HSnn+Wt/0ROEB3AFQmI97p9Dt6LBJZJb1u0aIXQkzD1h5iALAy54
         O9GglwqxD+V9lzpTzxOztBBAwks58ExlmArsl7tSwP6A6XsM2978sd3ajoJfeyhbkZ9W
         +l1fbvXxaSCjK5LJd378+XAxyz0/aKBbspvAA/WHA/sErFTzvdwDzFJo6zFadfLK0WQ/
         dakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707256700; x=1707861500;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXOY9GbyPZbALlw6ohTUWTlO4N2Ho7SwYMoN+axyaXU=;
        b=KGEMK9tf4EoA6SO9xpGWp7qLJoM3dmMDYKXrahwaZya0dzxaotJ2ioiLj2FBeYRtxF
         itX1FaGMJOEDLMb9Iln3ciPDkMpWmjpF8r/TtqxaHTcwhh0+I5gS4tFWGHeddWfni374
         3VvTa5/L6adpyZQk4ra8v0EL401aRXY1C2kC08zXIEINE8F7SLi9rgCGN4FokS2Z20XQ
         9trf4GlzxoMORy+xPevNwl8wBz2yeXiiDHLmwpCs4MOpRhw5F1Vtul3h5DbYRiER+bef
         PQrfZPFypWAtfROjEv1LKucPkacuyTGXziyIu0Cei8+JkuKyJQrypO6iX9fwlbVDrLy6
         FSSw==
X-Gm-Message-State: AOJu0YxPymVexuDy4sY9TiboSXZdGBBnY990AZraj7AmkHjVw6kPIndK
	Fe1iX5Isl/OZId+ikzfjFnYir1Ivv35jir6B8YeB+YpnoriLBgBEYTKsy5PqEa8=
X-Google-Smtp-Source: AGHT+IEstWqcfIfJtvHBGyo6/AaoIwSrRAHQu3gySee6U+tdWOH0LqITO0QDgiJ4X1cD/7vXcs4xsw==
X-Received: by 2002:a19:7403:0:b0:511:4a0b:b4c7 with SMTP id v3-20020a197403000000b005114a0bb4c7mr2508115lfe.34.1707256700050;
        Tue, 06 Feb 2024 13:58:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX8XeLvh1ziRY0LJ8K5/rmBti3r3fpKYKcM62SsjolYPcQTETJgz47Axe065tD5BPK0m1M5lUygNg7NG88ENOGE2uj1uZZLlKOaaUoE3Gfe8D8TvHx15XEq9v5YTXy5gKS01pOUh8Hk8eapmSwQYoipSLmusDNHsIVVxzfwYOJCYRL6FcUb32CVrgOfY01eIRkk7KJ5pJCvzdLCbM5xfXeDS5JWlOYxsgQsMtB8Cn0eAVeh6KPvJ8KDxrS2S1pRHcWCbEXAvyPjBql2MT0BuJw4
Received: from wkz-x13 (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id v4-20020a197404000000b0051142a07853sm346551lfe.19.2024.02.06.13.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:58:19 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, atenart@kernel.org,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH v3 net] net: bridge: switchdev: Skip MDB replays of
 pending events
In-Reply-To: <20240206193111.pm265ffzkmd7jbyo@skbuf>
References: <20240201161045.1956074-1-tobias@waldekranz.com>
 <20240201161045.1956074-1-tobias@waldekranz.com>
 <20240205114138.uiwioqstybmzq77b@skbuf> <87v871skwu.fsf@waldekranz.com>
 <20240206193111.pm265ffzkmd7jbyo@skbuf>
Date: Tue, 06 Feb 2024 22:58:18 +0100
Message-ID: <87sf25s1ad.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On tis, feb 06, 2024 at 21:31, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Tue, Feb 06, 2024 at 03:54:25PM +0100, Tobias Waldekranz wrote:
>> On m=C3=A5n, feb 05, 2024 at 13:41, Vladimir Oltean <olteanv@gmail.com> =
wrote:
>> > On Thu, Feb 01, 2024 at 05:10:45PM +0100, Tobias Waldekranz wrote:
>> >> Before this change, generation of the list of events MDB to replay
>> >
>> > s/events MDB/MDB events/
>> >
>> >> would race against the IGMP/MLD snooping logic, which could concurren=
tly
>> >
>> > logic. This could (...)
>> >
>> >> enqueue events to the switchdev deferred queue, leading to duplicate
>> >> events being sent to drivers. As a consequence of this, drivers which
>> >> reference count memberships (at least DSA), would be left with orphan
>> >> groups in their hardware database when the bridge was destroyed.
>> >
>> > Still missing the user impact description, aka "when would this be
>> > noticed by, and actively bother an user?". Something that would justify
>> > handling this via net.git rather than net-next.git.
>>=20
>> Other than moving up the example to this point, what do you feel is
>> missing? Or are you saying that you don't think this belongs on net.git?
>
> I just don't have enough data to be able to judge (it's missing from the
> commit message). I'm looking at Documentation/process/stable-kernel-rules=
.rst
> as a reference. It lists a series of guidelines from which I gather,
> generally speaking, that there should exist a user impact on
> functionality. The "mvls atu" command is a debug program, it just dumps
> hardware tables. It is enough to point out that multicast entries leak,
> but not what will be broken as a result of that.

Fair enough.

I originally discovered the issue while developing a kselftest for
another improvement I want to make to switchdev multicast offloading
(related to router ports). I thought my new code was causing these
orphan entries, but then realized that the issue existed on a plain -net
and -net-next kernel.

I can imagine scenarios in which a user _could_ be impacted by this, but
they are all quite esoteric. Maybe that is an indication that I should
just target net-next instead.

>> >> Avoid this by grabbing the write-side lock of the MDB while generating
>> >> the replay list, making sure that no deferred version of a replay
>> >> event is already enqueued to the switchdev deferred queue, before
>> >> adding it to the replay list.
>> >
>> > The description of the solution is actually not very satisfactory to m=
e.
>> > I would have liked to see a more thorough analysis.
>>=20
>> Sorry to disappoint.
>>=20
>> > The race has 2 components, one comes from the fact that during replay,
>> > we iterate using RCU, which does not halt concurrent updates, and the
>> > other comes from the fact that the MDB addition procedure is non-atomi=
c.
>> > Elements are first added to the br->mdb_list, but are notified to
>> > switchdev in a deferred context.
>> >
>> > Grabbing the bridge multicast spinlock only solves the first problem: =
it
>> > stops new enqueues of deferred events. We also need special handling of
>> > the pending deferred events. The idea there is that we cannot cancel
>> > them, since that would lead to complications for other potential
>> > listeners on the switchdev chain. And we cannot flush them either, sin=
ce
>> > that wouldn't actually help: flushing needs sleepable context, which is
>> > incompatible with holding br->multicast_lock, and without
>> > br->multicast_lock held, we haven't actually solved anything, since new
>> > deferred events can still be enqueued at any time.
>> >
>> > So the only simple solution is to let the pending deferred events
>> > execute (eventually), but during event replay on joining port, exclude
>> > replaying those multicast elements which are in the bridge's multicast
>> > list, but were not yet added through switchdev. Eventually they will b=
e.
>>=20
>> In my opinion, your three paragraphs above say pretty much the same
>> thing as my single paragraph. But sure, I will try to provide more
>> details in v4.
>
> It's not about word count, I'm notoriously bad at summarizing. If you
> could still say in a single paragraph what I did in 3, it would be great.
>
> The difference is that the above 3 paragraphs only explore the race on
> MDB addition events. It is of a different nature that the one on deletion.
> Your analysis clumps them together, and the code follows suit. There is
> code to supposedly handle the race between deferred deletion events and
> replay on port removal, but I don't think it does.

That's the thing though: I did not lump them together, I simply did not
think about the deletion issue at all. An issue which you yourself state
should probably be fixed in a separate patch, presumably becuase you
think of them as two very closely related, but ultimately separate,
issues. Which is why I think it was needlessly harsh to say that my
analysis of the duplicate-events-issue was too simplistic, because it
did not address a related issue that I had not considered.

>> > (side note: the handling code for excluding replays on pending event
>> > deletion seems to not actually help, because)
>> >
>> > Event replays on a switchdev port leaving the bridge are also
>> > problematic, but in a different way. The deletion procedure is also
>> > non-atomic, they are first removed from br->mdb_list then the switchdev
>> > notification is deferred. So, the replay procedure cannot enter a
>> > condition where it replays the deletion twice. But, there is no
>> > switchdev_deferred_process() call when the switchdev port unoffloads an
>> > intermediary LAG bridge port, and this can lead to the situation where
>> > neither the replay, nor the deferred switchdev object, trickle down to=
 a
>> > call in the switchdev driver. So for event deletion, we need to force a
>> > synchronous call to switchdev_deferred_process().
>>=20
>> Good catch!
>>=20
>> What does this mean for v4? Is this still one logical change that
>> ensures that MDB events are always delivered exactly once, or a series
>> where one patch fixes the duplicates and one ensures that no events
>> are missed?
>
> I'm not saying I know how you can satisfy everyone's review requests.

Of course, I was merely trying to avoid an extra round of patches.

> Once it is clear that deferred additions and deferred removals need
> separate treatment, it would probably be preferable to treat them in
> separate patches.

I should have been more clear in my response. When I said "Good catch!",
that was because I had first reproduced the issue, and then verified
that adding a call to switchdev_deferred_process() at the end of
nbp_switchdev_unsync_objs() solves the issue.

>> > See how the analysis in the commit message changes the patch?
>>=20
>> Suddenly the novice was enlightened.
>
> This, to me, reads like unnecessary sarcasm.

Your question, to me, read like unnecessary condescension.

> I just mean that I don't think you spent enough time to explore the
> problem space in the commit message. It is a very important element of
> a patch, because it is very rare for someone to solve a problem which
> is not even formulated. I actually tried to be helpful by pointing out
> where things might not work out. I'm sorry if it did not appear that way.

I am extremely greatful for your help, truly! Which is why I
complemented you for pointing out the second issue to me. Something
about the phrasing of that question really rubbed me the wrong way
though. I should have just let it go, I'm sorry.
