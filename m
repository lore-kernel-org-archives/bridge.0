Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E8F7F7F7
	for <bridge@lists.linux.dev>; Mon, 26 Feb 2024 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952725; cv=none; b=USG6bPD4PIT92G4w5pZrxLrJ1tVLLHmTD6BvNJ8fOWNiL8MLf/stLUWyVMMS2nb6dPcNHR9eQw0r2ezJBk6yaYkMUaMWYwFKLEoWd1YhljYkZFxAEEeLAgrryHk8k1scY0dWsGkDIh53L268o9jzvG1ojIghLd2LOymU4AqQuIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952725; c=relaxed/simple;
	bh=I9nudPBmH1+ABpCfIvC23xUTfEYS66YUpJFBesnh/ys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tyISvMhx9ky2ZvYbQWpsvL5eSwmmmNUKXOeo6OcoJtCF6DFvwNhEdLS4plJ7PX4JrjnFpF+iQwRQjTLvu8CD8cmwcfQEymK/CTMzatBpMoBycte6XR7IzVaBhBc3pa1x46zmtROipvDkL6j4BfvJg/ob1xs1dMKLl9DQ8TXhvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=f2+zSHgw; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="f2+zSHgw"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512b13bf764so3690426e87.0
        for <bridge@lists.linux.dev>; Mon, 26 Feb 2024 05:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1708952721; x=1709557521; darn=lists.linux.dev;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iXsjpaTb0bQigvYBS/pBWZ23VKwk/d7ZGal1Zt75OOY=;
        b=f2+zSHgwgcctiFAJ9CjBf1TctBtoSpuPDtSXN6+947hLdOWSqhf1aDJM6A7vF7APBW
         t178v8GrWpv9+YSX5RjooWcfw3h/puIGsItW3/nJNBPpcCipL/tLmLbRZgKJ16YJdm3c
         eYz3zj1Ud9YirmZyFsvQdqealCoESX4j/s7GNI0Dtj0bTTKiee1lZP9RqMq2BPvu7SMP
         V9AwEZJVq4toJ2xSL1lfjYCvhtQahd5ISZR+fEXm9aYbXMOoZ45AyV3OQWiparkTmdwn
         LsGvSU+iPVGl5Dgb2T3wS31d5zCBif+H1OKIYlUvNfCNi8Uag1ugLrJUoNsxmAqjFNqa
         dDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708952721; x=1709557521;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXsjpaTb0bQigvYBS/pBWZ23VKwk/d7ZGal1Zt75OOY=;
        b=UBoKAt2Er093wz2ra3Z/BcT4/FGXL3cviJ6kx+wp+Oshf66kZhr2UIZ3Rs5gjoZTjc
         WzF9fKmdc3niPURi6DU7whOkD/5HPEO+9NYEkyU/zlS75uYHP5S8XgXWjstxqtqdOsUL
         TcZHy9fL2XPSz74YMmk9GwHD9++kviGHterD5tQZdomzgZdXEaKZ3sEgidmEL7B0T4OH
         LYqeBwKOw7HuKtnvqEZR9I8aqUnF5sRMPlh1Twn3iYyn26DbIigtPBI3+BHBLZ6mybYn
         5nnrZvzm/xqaHuOFn5YhsNe/ZcRB1uL37VdIgnPbRa5xHggE3WT8AupBmyXGGhgwU1XB
         M72w==
X-Forwarded-Encrypted: i=1; AJvYcCX1/rzC8dvr+Bc6eGy32rzSRNH7JDzzJDN+xtTGa79m5LrNJirAdJehK2yK3w3036DkC5TM04wS80QARR63WQRB1tXC+mxL
X-Gm-Message-State: AOJu0YxayYajFrdKz4jJNo984Ms/mRl9x/Q6A6bmB8cEMRNoXxGtFd/K
	UHceAao0zhC2W0Xfyx6GlfPOvhZKVC3sVAFxKZPUrsO30MNZ5pz1+3XPhsNATwQ=
X-Google-Smtp-Source: AGHT+IG5hh7CurEjOaQi9heB+jROTX4JXnIOCWWtXdCKtxsZKsex4mK150b3mCJbu2almX5myN8AvQ==
X-Received: by 2002:ac2:4da9:0:b0:512:f4bb:d3c5 with SMTP id h9-20020ac24da9000000b00512f4bbd3c5mr3875078lfe.7.1708952721378;
        Mon, 26 Feb 2024 05:05:21 -0800 (PST)
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id g11-20020ac24d8b000000b00512c9c3aefasm836795lfe.236.2024.02.26.05.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 05:05:20 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com,
 razor@blackwall.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
 jiri@resnulli.us, ivecera@redhat.com, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 4/4] net: switchdev: Add tracepoints
In-Reply-To: <20240223103815.35fdf430@gandalf.local.home>
References: <20240223114453.335809-1-tobias@waldekranz.com>
 <20240223114453.335809-5-tobias@waldekranz.com>
 <20240223103815.35fdf430@gandalf.local.home>
Date: Mon, 26 Feb 2024 14:05:20 +0100
Message-ID: <87cysjgyun.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On fre, feb 23, 2024 at 10:38, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 23 Feb 2024 12:44:53 +0100
> Tobias Waldekranz <tobias@waldekranz.com> wrote:
>
>> Add a basic set of tracepoints:
>> 
>> - switchdev_defer: Fires whenever an operation is enqueued to the
>>   switchdev workqueue for deferred delivery.
>> 
>> - switchdev_call_{atomic,blocking}: Fires whenever a notification is
>>   sent to the corresponding switchdev notifier chain.
>> 
>> - switchdev_call_replay: Fires whenever a notification is sent to a
>>   specific driver's notifier block, in response to a replay request.
>> 
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>>  include/trace/events/switchdev.h | 74 ++++++++++++++++++++++++++++++++
>>  net/switchdev/switchdev.c        | 71 +++++++++++++++++++++++++-----
>>  2 files changed, 135 insertions(+), 10 deletions(-)
>>  create mode 100644 include/trace/events/switchdev.h
>> 
>> diff --git a/include/trace/events/switchdev.h b/include/trace/events/switchdev.h
>> new file mode 100644
>> index 000000000000..dcaf6870d017
>> --- /dev/null
>> +++ b/include/trace/events/switchdev.h
>> @@ -0,0 +1,74 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM	switchdev
>> +
>> +#if !defined(_TRACE_SWITCHDEV_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_SWITCHDEV_H
>> +
>> +#include <linux/tracepoint.h>
>> +#include <net/switchdev.h>
>> +
>> +#define SWITCHDEV_TRACE_MSG_MAX 128
>
> 128 bytes is awfully big to waste on the ring buffer. What's the average
> size of a string?

I would say the typical message is around 60-80 bytes. Some common examples:

    PORT_OBJ_ADD PORT_VLAN(flags 0x0 orig br0) vid 1 flags 0x27
    PORT_OBJ_DEL HOST_MDB(flags 0x0 orig br0) vid 100 addr 33:33:ff:ff:00:09

The worst case I can think of currently is 95 characters:

    VXLAN_FDB_ADD_TO_DEVICE vid 1000 addr de:ad:be:ef:00:01 added_by_user is_local locked offloaded

>> +
>> +DECLARE_EVENT_CLASS(switchdev_call,
>> +	TP_PROTO(unsigned long val,
>> +		 const struct switchdev_notifier_info *info,
>> +		 int err),
>> +
>> +	TP_ARGS(val, info, err),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(unsigned long, val)
>> +		__string(dev, info->dev ? netdev_name(info->dev) : "(null)")
>> +		__field(const struct switchdev_notifier_info *, info)
>> +		__field(int, err)
>> +		__array(char, msg, SWITCHDEV_TRACE_MSG_MAX)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->val = val;
>> +		__assign_str(dev, info->dev ? netdev_name(info->dev) : "(null)");
>> +		__entry->info = info;
>> +		__entry->err = err;
>> +		switchdev_notifier_str(val, info, __entry->msg, SWITCHDEV_TRACE_MSG_MAX);
>
> Is it possible to just store the information in the trace event and then
> call the above function in the read stage? There's helpers to pass strings
> around (namely a struct trace_seq *p).

I'm a complete novice when it comes to tracepoint internals. Am I right
in assuming that TP_printk may execute at a much later time than
TP_fast_assign? E.g., the object referenced by __entry->info may very
well have been freed by that time? That at least seems to be what my
naive refactor to replace __entry->msg with __get_buf() suggests :)

If so, the layout of the switchdev_notifier_* structs makes it a bit
cumbersome to clone the notification in the assign phase, as the size of
a specific notification (e.g., switchdev_notifier_port_obj_info) is not
known by the common notification (switchdev_notifier_info). In the case
of switchdev objects, the problem repeats a second time. E.g., the size
of switchdev_obj_port_vlan is not known by switchdev_obj.

> It would require a plugin for libtraceevent if you want to expose it to
> user space tools for trace-cmd and perf though.
>
> Another possibility is if this event will not race with other events on he
> same CPU, you could create a per-cpu buffer, write into that, and then use
> __string() and __assign_str() to save it, as traces happen with preemption
> disabled.

But bottom halves are still enabled I suppose? Notifications can be
generated both from process context (e.g., users configuring the bridge
with iproute2), and from bridge packet processing (e.g., adding new
neighbors to the FDB). So I don't think that would work in this case.

> -- Steve

Thanks for taking the time!

>> +	),
>> +
>> +	TP_printk("dev %s %s -> %d", __get_str(dev), __entry->msg, __entry->err)
>> +);
>> +
>> +DEFINE_EVENT(switchdev_call, switchdev_defer,
>> +	TP_PROTO(unsigned long val,
>> +		 const struct switchdev_notifier_info *info,
>> +		 int err),
>> +
>> +	TP_ARGS(val, info, err)
>> +);
>> +
>> +DEFINE_EVENT(switchdev_call, switchdev_call_atomic,
>> +	TP_PROTO(unsigned long val,
>> +		 const struct switchdev_notifier_info *info,
>> +		 int err),
>> +
>> +	TP_ARGS(val, info, err)
>> +);
>> +
>> +DEFINE_EVENT(switchdev_call, switchdev_call_blocking,
>> +	TP_PROTO(unsigned long val,
>> +		 const struct switchdev_notifier_info *info,
>> +		 int err),
>> +
>> +	TP_ARGS(val, info, err)
>> +);
>> +
>> +DEFINE_EVENT(switchdev_call, switchdev_call_replay,
>> +	TP_PROTO(unsigned long val,
>> +		 const struct switchdev_notifier_info *info,
>> +		 int err),
>> +
>> +	TP_ARGS(val, info, err)
>> +);
>> +
>> +#endif /* _TRACE_SWITCHDEV_H */
>> +
