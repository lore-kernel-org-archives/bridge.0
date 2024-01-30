Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A0F762EE
	for <bridge@lists.linux.dev>; Tue, 30 Jan 2024 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649821; cv=none; b=ZBX+n5+4QJ7qrx8QxRfB/1P4ztASIget1h4JCrbJ751PguOZsAdysnz1/GcL/VEkfmydtKdBO0m5/s8MH8ZsE3j/KoX3rYoIApvSWqP/gnP3Nnb+T+7/z9skRsc5v+2OOzE5RLzRWXfpLOPGoyofW3TH6F7UodMxCc8c2F+MFfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649821; c=relaxed/simple;
	bh=zY6J04vbFol813EKgL+EgED1mE5uffElI8AOg6+02rU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o+i3oqrf1uiFeLbgFvTeJzQKEZ/nyhq1uZiycj+VHhTay5P5HAHYInJczDMcNCUFI3nf5rWFutpU8lIA1wQceEHZfiHlhEJTw4mW1+Z3W2EihJP+uvTbWs0XhAdJJiPPOJ9zuHJu6rmgjQdJptfbBWD74JgD6ttuh/Jv+GBF1lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=QZJEEObd; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="QZJEEObd"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cf2adac1ccso51451461fa.3
        for <bridge@lists.linux.dev>; Tue, 30 Jan 2024 13:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706649816; x=1707254616; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePlKxWD16Ejr/04lz9h5y1o+fUoZJDg4aTLoVAhkZwg=;
        b=QZJEEObd8XKfRTTaRNCRzWVceFzNizUQ62BGWaVJmAWy4xa3K0MlgY+JCLkgdgoack
         GxA/u6c6tJvAQPOe51/llKoI4Y4AguNzF0KevWLmwCbx+lo+EoePyOg1wA545eCLBrB6
         RZfwR8lJ0Vywbap0wL4B6Ga7MREStW4ZbLWsdAMi61by4THnl3DXa6UPfwlXp26SAs42
         TR5ud+7WH7Hw/bCOdG6cGGFus7UfpABFCXRR2I21nQBW2CQrj58QOfKpK2Z4ti3JjZmj
         a7dFvw204tvJ8rJqk31UYlJFQtCR9Jvz9/Q5tKoB+HhxfLscXI4et+QsVJIZfwQw/tyN
         4s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649816; x=1707254616;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePlKxWD16Ejr/04lz9h5y1o+fUoZJDg4aTLoVAhkZwg=;
        b=swJrOM4RaAGN6eEWkyx2/5+JiF+MLZHIqlo/566Ih5w+bEL90KZNv/VspkgavDNaNI
         xv5QjOUdLNS/NdF4koENnOBTQvbX1wec8uu9HBGM3/5leEDei/y78EvgU4F/h0uTAmql
         VhvLNV+Q62CCVFUcqH/wPkGvnw/9OV7v/X1HQ6ido0by2tvaTBeg5Ey1fGbzkahhPCGG
         gAMxPEsZEUJzjzlinje75F9VZCs9cIgp3odt8WiYlH/GPRym6NKFtL5S5c8jjwQCdUJh
         Ppo/q389TETFDUgjqC+PKKdNd9kFoyZXwGCs4PhMaXHwgO9hEC6cqjj57CJeWgcy0Wfs
         g2ew==
X-Gm-Message-State: AOJu0YwPe2MNFCMtJJmnHcQDbCvA50fWqEzkVO3EpuGQnbHpf2cqj/Ce
	LTdKEWmL4CfSp5A+LIZtmtMdZ7zJFSvUmMkFAuuqnpmDVONbdXCr6ibc/6XNuG/kv49BcWB+u04
	y
X-Google-Smtp-Source: AGHT+IEVU0SewU9jx9Kv43HI3Eij8p8MmFlbQx0pIWw/3ndGlz1U/l3c4gulFgvce6z2rtb37Rc3XQ==
X-Received: by 2002:a2e:9b14:0:b0:2cc:ef84:a3a3 with SMTP id u20-20020a2e9b14000000b002ccef84a3a3mr6339751lji.44.1706649815988;
        Tue, 30 Jan 2024 13:23:35 -0800 (PST)
Received: from wkz-x13 (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id b5-20020a2e8945000000b002cb28360049sm1694917ljk.96.2024.01.30.13.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:23:35 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: jiri@resnulli.us, ivecera@redhat.com, roopa@nvidia.com,
 razor@blackwall.org, netdev@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: net: switchdev: Port-to-Bridge Synchronization
In-Reply-To: <20240129121739.3ppum5ewok6atckz@skbuf>
References: <87fryl6l2a.fsf@waldekranz.com>
 <20240129121739.3ppum5ewok6atckz@skbuf>
Date: Tue, 30 Jan 2024 22:23:34 +0100
Message-ID: <87bk927bxl.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On m=C3=A5n, jan 29, 2024 at 14:17, Vladimir Oltean <olteanv@gmail.com> wro=
te:
> Hi Tobias,
>
> On Fri, Jan 26, 2024 at 12:38:05AM +0100, Tobias Waldekranz wrote:
>> Hello netdev,
>>=20
>> Let me start by describing an issue that I have found in the
>> bridge/switchdev replay logic, which will lead to a larger question
>> about how switchdev ports are synchronized with a bridge. Anyway, on the
>> bug!
>>=20
>> The steps to reproduce the issue are very simple on my board, but I've
>> never seen it before, so it could be that you need a pretty fast (by
>> embedded standards) SMP CPU to trigger the race.
>>=20
>> Hardware:
>> - Marvell CN9130 SoC
>> - Marvell 88E6393X Switch
>>=20
>> Steps:
>> 1. Create a bridge with multicast snooping enabled
>> 2. Attach an switch port to the bridge
>> 3. Remove the bridge
>>=20
>> If (2) is done immediately after (1), then my switch's hardware MDB will
>> be left with two orphan entries after removing the bridge (3).
>>=20
>> On a system running net-next with the switchdev tracepoint series[1]
>> applied, this is what it looks like (with comm, pid, timestamp
>> etc. trimmed from the trace output to make the lines a bit narrower,
>> with an event number added instead):
>>=20
>> root@infix-06-0b-00:~$ echo 1 >/sys/kernel/debug/tracing/events/switchde=
v/enable
>> root@infix-06-0b-00:~$ cat /sys/kernel/debug/tracing/trace_pipe | grep H=
OST_MDB &
>> [1] 2602
>> root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snooping=
 1 && ip link set dev x3 up master br0
>> 01: switchdev_defer: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vi=
d 0 addr 33:33:ff:87:e4:3f
>> 02: switchdev_defer: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vi=
d 0 addr 33:33:00:00:00:6a
>> 03: switchdev_call_replay: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x0 orig b=
r0) vid 0 addr 33:33:00:00:00:6a -> 0
>> 04: switchdev_call_replay: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x0 orig b=
r0) vid 0 addr 33:33:ff:87:e4:3f -> 0
>> 05: switchdev_call_blocking: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig=
 br0) vid 0 addr 33:33:ff:87:e4:3f -> 0
>> 06: switchdev_call_blocking: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig=
 br0) vid 0 addr 33:33:00:00:00:6a -> 0
>> 07: switchdev_defer: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vi=
d 0 addr 33:33:00:00:00:fb
>> 08: switchdev_call_blocking: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig=
 br0) vid 0 addr 33:33:00:00:00:fb -> 0
>> root@infix-06-0b-00:~$ ip link del dev br0
>> 09: switchdev_call_replay: dev x3 PORT_OBJ_DEL HOST_MDB(flags 0x0 orig b=
r0) vid 0 addr 33:33:00:00:00:fb -> 0
>> 10: switchdev_call_replay: dev x3 PORT_OBJ_DEL HOST_MDB(flags 0x0 orig b=
r0) vid 0 addr 33:33:00:00:00:6a -> 0
>> 11: switchdev_call_replay: dev x3 PORT_OBJ_DEL HOST_MDB(flags 0x0 orig b=
r0) vid 0 addr 33:33:ff:87:e4:3f -> 0
>> root@infix-06-0b-00:~$ mvls atu
>> ADDRESS             FID  STATE      Q  F  0  1  2  3  4  5  6  7  8  9  a
>> DEV:0 Marvell 88E6393X
>> 33:33:00:00:00:6a     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
>> 33:33:ff:87:e4:3f     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
>> ff:ff:ff:ff:ff:ff     1  static     -  -  0  1  2  3  4  5  6  7  8  9  a
>> root@infix-06-0b-00:~$
>>=20
>> Event 01 and 02 are generated when the bridge is parsing an MLD report
>> generated by the kernel to register membership in the interface's link
>> local group address and the All-Snoopers group. As we are in softirq
>> context, the events are placed in the deferred queue.
>>=20
>> More or less concurrently, the port is joining the bridge, and the DSA
>> layer is sending a SWITCHDEV_BRPORT_OFFLOADED to request a replay of all
>> relevant events that happened before it joined. Since we now find the
>> two host entries in the bridge's MDB, we replay the events (03 and 04).
>>=20
>> Once the replay is done, at some later point in time, we start to
>> process the deferred events and send 05 and 06 (originally 01 and 02) to
>> the driver again.
>>=20
>> At this point, the DSA layer will have a recorded refcount of 2 for both
>> of the groups in question, whereas the bridge only holds a single
>> reference count of each membership.
>>=20
>> Therefore, when we tear down the bridge, the corresponding UNOFFLOADED
>> event will trigger another replay cycle, which will send a single delete
>> event for each group, leaving the DSA layer's refcount at 1. This is
>> confirmed by the mvls output, showing the two groups are still loaded in
>> the ATU.
>>=20
>> The end (of the bug report)
>>=20
>> How can we make sure that this does not happen?
>>=20
>> Broadly, it seems to me like we need the bridge to signal the start and
>> end of a replay sequence (via the deferred queue), which the drivers can
>> then use to determine when it should start/stop accepting deferred
>> messages. I think this also means that we have to guarantee that no
>> new events of a particular class can be generated while we are scanning
>> the database of those objects and generating replay events.
>>=20
>> Some complicating factors:
>>=20
>> - There is no single stream of events to synchronize with.
>>   - Some calls are deferred for later dispatch
>>   - Some are run synchronously in a blocking context
>>   - Some are run synchronously in an atomic context
>>=20
>> - The rhashtable which backs the FDB is designed to be lock-free, making
>>   it hard to ensure atomicity between a replay cycle and new addresses
>>   being learned in the hotpath
>>=20
>> - If we take this approach, how can we make sure that most of the
>>   driver-side implementation can be shared in switchdev.c, and doesn't
>>   have to be reinvented by each driver?
>>=20
>> I really hope that someone can tell my why this problem is much easier
>> than this!
>>=20
>> [1]: https://lore.kernel.org/netdev/20240123153707.550795-1-tobias@walde=
kranz.com/
>
> Please expect a few weeks from my side until I could take a close look
> at this. Otherwise, here are some superficial (and maybe impractical) ide=
as.

Thanks for taking the time!

> I agree that the replay procedures race with the data path. Let's try to
> concentrate on one at a time, and then see how the others are different.

Right, I think this is the key. I was focusing too much on finding one
solution to fix all replay races. I will start with the MDB.

> We seem to need to distinguish the events that happened before the
> SWITCHDEV_BRPORT_OFFLOADED event from those that happened afterwards.
> The SWITCHDEV_BRPORT_OFFLOADED event itself runs under rtnl_lock()
> protection, and so does switchdev_deferred_process(). So, purely from a
> switchdev driver API perspective, things are relatively coarse grained,
> and the order of operations within the NETDEV_CHANGEUPPER handler is not
> very important, because at the end of the day, only this is: before
> NETDEV_CHANGEUPPER, the port is not ready to process deferred switchdev
> events, and after NETDEV_CHANGEUPPER, it is.
>
> The problem is figuring out, during this relatively large rtnl_lock()
> section, where to delineate events that are 'before' vs 'after'. We must
> only replay what's 'before'.
>
> Multicast database entries seem to have br->multicast_lock for serializing
> writers. Currently we are not acquiring that during replay.
>
> I'm thinking we could do something like this in br_switchdev_mdb_replay().
> We could block concurrent callers to br_switchdev_mdb_notify() by
> acquiring br->multicast_lock, so that br->mdb_list stays constant for a
> while.
>
> Then, after constructing the local mdb_list, the problem is that it
> still contains some SWITCHDEV_F_DEFER elements which are pending a call
> switchdev_deferred_process(). But that can't run currently, so we can
> iterate through switchdev's "deferred" list and remove them from the
> replay list, if we figure out some sort of reliable switchdev object
> comparison function. Then we can safely release br->multicast_lock.

That would _almost_ work, I think. But instead of purging the deferred
items, I think we have to skip queuing the replay events in these
cases. Otherwise we limit the scope of the notification to the
requesting driver, when it ought to reach all registered callbacks on
the notifier chain.

This matters if a driver wants to handle foreign group memberships the
same way we do with FDB entries, which I want to add to DSA once this
race has been taken care of.

> The big problem I see is that FDB notifications don't work that way.
> They are also deferred, but all the deferred processing is on the
> switchdev driver side, not on the bridge side. One of the reasons is
> that the deferred side should not need rtnl_lock() at all. I don't see
> how this model would scale to FDB processing.

Yeah, that's where I threw in the towel as well. That issue will just
have to go unsolved for now.
