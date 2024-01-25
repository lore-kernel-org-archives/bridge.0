Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD118E1F
	for <bridge@lists.linux.dev>; Thu, 25 Jan 2024 23:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706225893; cv=none; b=RL6CzmAIRkCHCpF4WZb88C4l3zcKTal+QzO58BfbUTyMYK7Ppt4Ocs5ZYG1nrT1vpc5kxJhblvlVdFC7rk3hCOmUnQGRz+AOIfV3/M2e7Ikj/jwizCJTGovmZqEWcnJhB6F6eVJyrgrHphELgBlb0KLmKoCbuQapNcxXalfXdqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706225893; c=relaxed/simple;
	bh=rQxsIPw4ltyNyopc66d4dKSxBhDm6RQUyfXO/Es/Zu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FUucvMw1SQEM+IqbVyFlzO6wC897NNQ9WQ1PknY6YExF3hy7ebYu/pFlH0MYGLHn5ZEOgDq1iL2NEWUuhBDslFNFyBZVchX6ObkOQWZdXE0qzaoZM1tqKcVqTcfXRrLm5jP+NBgFEwPhsNO9z2uUe/ERtVTMAlpa9066rqxXNyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=3RofB+de; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="3RofB+de"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50f1c524010so8418608e87.3
        for <bridge@lists.linux.dev>; Thu, 25 Jan 2024 15:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706225888; x=1706830688; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dwubq2bYae3KBFecFHPHMYc1hmT+c4+sZe86rg5b7U4=;
        b=3RofB+deIMqn6WVH8tK/+T3WhHJfEYp5AJbEfyy/pdGxIyKYTFo0DfLOIQ3bsSMpdx
         yHrAUKZkz2AWA/zYf1yG3tpRpZPFj3PXYJJgLIy+z1zJ6csFQ3FTIafConaiPW4zBnA9
         svaZFFliQSNyZziSucPV36hjYrgzWvGDRBj/SherzOX8jovgxiBVBHq2+z6GA+jnuDcq
         bbOHCLXr7aEu3/AAxe2OYVOEzbmJ7mKSPBzuNaYX0XEa+73oJGUWp8VQOoe01BCDJE48
         FklYjwz3kX2jRaacE9KyKmSKo4A4hwKjtVIWF4NYnhEXcSuSCsjwnKtQuff+PQBHifd+
         oE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706225888; x=1706830688;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dwubq2bYae3KBFecFHPHMYc1hmT+c4+sZe86rg5b7U4=;
        b=nwnCWoE+zZt1bg61tDgyKbpnLx+hf0cbOJVH7jIr/dzSS0gWQIUGIlKccueI58d1uE
         Vn68EX3uWPWba7DaySU4nayDwFnRwzoo2yVqbnaVe119zZ62/DGa05RJRpOHj6QNKpjt
         nyeBwEvGLdrcfn/vRk5Na6UgQPZnv+AJVFIz8Kc9wUwD9Wm4Roo78iT476CfHCcqlEAa
         mjo+up/oPH+y+7M6EEbn8ifFV6kF9j+M7GDRZ31DQOWGqS9sFCt5w6azhQQ8ymZuvwbN
         +o2crzg3uq3gZNT+xT5ONPq7v55gjtud370ItQRAV820RD7gidjv+P7xOCH9INyOaRIf
         0bYA==
X-Gm-Message-State: AOJu0YzIp50k0eBnU4tIU6gZT3on+iM60VVxBNSNeiC/upfQJt8cj4EV
	T0ziE46jECR3fa2KRas+tAz9VTp2n/+2V1lGJJL9K65PCKRGHtKtzlDDAzqXGKvePT3Gss53yRG
	J
X-Google-Smtp-Source: AGHT+IHvQiqN05UMfEGVZMojCnj+FENSv7WHyLXhRXyUIhaU0wEIYILnj/2jROtpiZTVn9a6PL5nBg==
X-Received: by 2002:a19:384c:0:b0:510:df8:72cf with SMTP id d12-20020a19384c000000b005100df872cfmr155947lfj.175.1706225887182;
        Thu, 25 Jan 2024 15:38:07 -0800 (PST)
Received: from wkz-x13 (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id v17-20020ac258f1000000b0050e7dcc05a5sm8277lfo.102.2024.01.25.15.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 15:38:06 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: jiri@resnulli.us, ivecera@redhat.com, roopa@nvidia.com,
 razor@blackwall.org, olteanv@gmail.com
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev
Subject: net: switchdev: Port-to-Bridge Synchronization
Date: Fri, 26 Jan 2024 00:38:05 +0100
Message-ID: <87fryl6l2a.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hello netdev,

Let me start by describing an issue that I have found in the
bridge/switchdev replay logic, which will lead to a larger question
about how switchdev ports are synchronized with a bridge. Anyway, on the
bug!

The steps to reproduce the issue are very simple on my board, but I've
never seen it before, so it could be that you need a pretty fast (by
embedded standards) SMP CPU to trigger the race.

Hardware:
- Marvell CN9130 SoC
- Marvell 88E6393X Switch

Steps:
1. Create a bridge with multicast snooping enabled
2. Attach an switch port to the bridge
3. Remove the bridge

If (2) is done immediately after (1), then my switch's hardware MDB will
be left with two orphan entries after removing the bridge (3).

On a system running net-next with the switchdev tracepoint series[1]
applied, this is what it looks like (with comm, pid, timestamp
etc. trimmed from the trace output to make the lines a bit narrower,
with an event number added instead):

root@infix-06-0b-00:~$ echo 1 >/sys/kernel/debug/tracing/events/switchdev/enable
root@infix-06-0b-00:~$ cat /sys/kernel/debug/tracing/trace_pipe | grep HOST_MDB &
[1] 2602
root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snooping 1 && ip link set dev x3 up master br0
01: switchdev_defer: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:ff:87:e4:3f
02: switchdev_defer: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:00:00:00:6a
03: switchdev_call_replay: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x0 orig br0) vid 0 addr 33:33:00:00:00:6a -> 0
04: switchdev_call_replay: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x0 orig br0) vid 0 addr 33:33:ff:87:e4:3f -> 0
05: switchdev_call_blocking: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:ff:87:e4:3f -> 0
06: switchdev_call_blocking: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:00:00:00:6a -> 0
07: switchdev_defer: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:00:00:00:fb
08: switchdev_call_blocking: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:00:00:00:fb -> 0
root@infix-06-0b-00:~$ ip link del dev br0
09: switchdev_call_replay: dev x3 PORT_OBJ_DEL HOST_MDB(flags 0x0 orig br0) vid 0 addr 33:33:00:00:00:fb -> 0
10: switchdev_call_replay: dev x3 PORT_OBJ_DEL HOST_MDB(flags 0x0 orig br0) vid 0 addr 33:33:00:00:00:6a -> 0
11: switchdev_call_replay: dev x3 PORT_OBJ_DEL HOST_MDB(flags 0x0 orig br0) vid 0 addr 33:33:ff:87:e4:3f -> 0
root@infix-06-0b-00:~$ mvls atu
ADDRESS             FID  STATE      Q  F  0  1  2  3  4  5  6  7  8  9  a
DEV:0 Marvell 88E6393X
33:33:00:00:00:6a     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
33:33:ff:87:e4:3f     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
ff:ff:ff:ff:ff:ff     1  static     -  -  0  1  2  3  4  5  6  7  8  9  a
root@infix-06-0b-00:~$

Event 01 and 02 are generated when the bridge is parsing an MLD report
generated by the kernel to register membership in the interface's link
local group address and the All-Snoopers group. As we are in softirq
context, the events are placed in the deferred queue.

More or less concurrently, the port is joining the bridge, and the DSA
layer is sending a SWITCHDEV_BRPORT_OFFLOADED to request a replay of all
relevant events that happened before it joined. Since we now find the
two host entries in the bridge's MDB, we replay the events (03 and 04).

Once the replay is done, at some later point in time, we start to
process the deferred events and send 05 and 06 (originally 01 and 02) to
the driver again.

At this point, the DSA layer will have a recorded refcount of 2 for both
of the groups in question, whereas the bridge only holds a single
reference count of each membership.

Therefore, when we tear down the bridge, the corresponding UNOFFLOADED
event will trigger another replay cycle, which will send a single delete
event for each group, leaving the DSA layer's refcount at 1. This is
confirmed by the mvls output, showing the two groups are still loaded in
the ATU.

The end (of the bug report)

How can we make sure that this does not happen?

Broadly, it seems to me like we need the bridge to signal the start and
end of a replay sequence (via the deferred queue), which the drivers can
then use to determine when it should start/stop accepting deferred
messages. I think this also means that we have to guarantee that no
new events of a particular class can be generated while we are scanning
the database of those objects and generating replay events.

Some complicating factors:

- There is no single stream of events to synchronize with.
  - Some calls are deferred for later dispatch
  - Some are run synchronously in a blocking context
  - Some are run synchronously in an atomic context

- The rhashtable which backs the FDB is designed to be lock-free, making
  it hard to ensure atomicity between a replay cycle and new addresses
  being learned in the hotpath

- If we take this approach, how can we make sure that most of the
  driver-side implementation can be shared in switchdev.c, and doesn't
  have to be reinvented by each driver?

I really hope that someone can tell my why this problem is much easier
than this!

[1]: https://lore.kernel.org/netdev/20240123153707.550795-1-tobias@waldekranz.com/
