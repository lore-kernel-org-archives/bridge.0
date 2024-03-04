Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B181C6AB
	for <bridge@lists.linux.dev>; Mon,  4 Mar 2024 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592055; cv=none; b=UqeYt86cuwzJmDAC8sd9cqqrdty/XSjCEK0SJKalEgTTkqHQtN2m075PIHjKHQhMk0OMlD2n7+XJOcCInZtZQNmbhcw9Gw7ePDJ97RW4JqfOLlDMPPKcaBZem0IEGg9zlsdVRizJWOGop24WUvJuKS6mchLjlQi5LyAK5XjmDIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592055; c=relaxed/simple;
	bh=5XXHkM40iiZTjxlfUzE91RiBOCSflLc2nfbu/SaZ7VY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mw0FvQVYZARswunKo2TKB1JhOom10R4qWQB5w9l5fpZ0OJaEB1Gw/KqPmiaoUAvKTsylbZQYmDSSkrFcVTRH7n9tWFpr1KWMZulBaiZASmpFRYXguJbz8nKNO2r96+U9lz9MJvJwKmpW8kB4esPZkayPB6Pq0u8vFyT6TjiBKQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=bFWBwY4S; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="bFWBwY4S"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d28387db09so60084701fa.0
        for <bridge@lists.linux.dev>; Mon, 04 Mar 2024 14:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1709592052; x=1710196852; darn=lists.linux.dev;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cdh0FQGbsGzvigQxix/33N2xTkkyynvJysdSSvdUw/k=;
        b=bFWBwY4SSnKCQAKNyghRR+/cYidw3K216X36JPN5azu7kwqOV1jz3btaXVdbdx+g7g
         iy/CPF1W0r7O9vZRsrTjeOo9ZNS0Mbh4XDvn39ud2OiOS8/dEUz9FKdGSMbCaKtKa2Zj
         JOOIQN8llbE9prKk9ecp2GeqGErxpnco+pceItwQHtNKvOfSC5ax81Fwz9PlVuPtFZz9
         zg1nC0NpVFm0XsW0kv4ipGb9eEmev2V2JTdl1AQ+G4Gy9lYyE6Q4B96uVbsDFj4ujs3g
         kraCTQOAY9J4Btxy1Rq10acxPNdZg5XpYIQ4dJAUzjAeByUXblTrmtDJmYIh07L0eLNM
         4QhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592052; x=1710196852;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cdh0FQGbsGzvigQxix/33N2xTkkyynvJysdSSvdUw/k=;
        b=LMzeHa0uDWR2VicqMfKu8UqRSr0sfgaqDYg1w8vadv1GS18XRpTS7XHmBSOT2baWSG
         WNv3br1OAE64wIQnseezgzdO6mVXdzJfNSlZff7T3tXuYQJgnQzdwgYssfjRBZ3gWZ9s
         05Yz4d/CUDOu3h/avATTPZoxiGWYtwi8OXzIp4UwuLIEzlRtzWbJT3+Hx+nn25RC2sJd
         R04mDVS+my6WwcrzNsb4yUXFlN1j6+kVwa+LLxn+x9ycnmk5dXoMv05Ljb3qBCCuHxPT
         v3meQTp2nMtNRF5CS+6f2Jffme3pq73iWVoqDGAvvS8JI6Ny9jYU34CAe3lywsDzUldp
         vX6w==
X-Forwarded-Encrypted: i=1; AJvYcCX1FsqLdyWatQJ6dK/ZFrjQeryyy7PkT9M99wy4y6skI4HtjsXuf/czKMViXL56Gz29rLwTxKWKymInRMVFIqXm7n8r1A7D
X-Gm-Message-State: AOJu0YygI0LOaJ7Lw01UWZude3NC2M4pY6zO/Ml7o48gKAG8gBonmkg5
	5Hs2/IL6d8To3ttdZXf9dKsoy51arwimg4Gorm647hzTJdloQMWdLlFgtvvYc/A=
X-Google-Smtp-Source: AGHT+IGg/uCC7hFxHYqui84BZlHHuBl0x+92dDxwC2cR3sRjEmRA8Zpl/zu6I+pg9ZhRpfixGDWZNQ==
X-Received: by 2002:ac2:5e7c:0:b0:512:f5af:3bdf with SMTP id a28-20020ac25e7c000000b00512f5af3bdfmr75071lfr.68.1709592051651;
        Mon, 04 Mar 2024 14:40:51 -0800 (PST)
Received: from wkz-x13 (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id i27-20020ac25b5b000000b005128cf5b323sm1913264lfp.251.2024.03.04.14.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:40:50 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, kuba@kernel.org,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com,
 mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 4/4] net: switchdev: Add tracepoints
In-Reply-To: <20240228095648.646a6f1a@gandalf.local.home>
References: <20240223114453.335809-1-tobias@waldekranz.com>
 <20240223114453.335809-5-tobias@waldekranz.com>
 <20240223103815.35fdf430@gandalf.local.home>
 <4838ad92a359a10944487bbcb74690a51dd0a2f8.camel@redhat.com>
 <87a5nkhnlv.fsf@waldekranz.com>
 <20240228095648.646a6f1a@gandalf.local.home>
Date: Mon, 04 Mar 2024 23:40:49 +0100
Message-ID: <877cihhb7y.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On ons, feb 28, 2024 at 09:56, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 28 Feb 2024 11:47:24 +0100
> Tobias Waldekranz <tobias@waldekranz.com> wrote:
>
>> >> > +	TP_fast_assign(
>> >> > +		__entry->val = val;
>> >> > +		__assign_str(dev, info->dev ? netdev_name(info->dev) : "(null)");
>> >> > +		__entry->info = info;
>> >> > +		__entry->err = err;
>> >> > +		switchdev_notifier_str(val, info, __entry->msg, SWITCHDEV_TRACE_MSG_MAX);  
>> >> 
>> >> Is it possible to just store the information in the trace event and then
>> >> call the above function in the read stage?  
>> >
>> > I agree with Steven: it looks like that with the above code the
>> > tracepoint itself will become measurably costily in terms of CPU
>> > cycles: we want to avoid that.
>> >
>> > Perhaps using different tracepoints with different notifier_block type
>> > would help? so that each trace point could just copy a few specific
>> > fields.  
>> 
>> This can be done, but you will end up having to duplicate the decoding
>> and formatting logic from switchdev-str.c, with the additional hurdle of
>> having to figure out the sizes of all referenced objects in order to
>> create flattened versions of every notification type.
>
> Would it help if you could pass a trace_seq to it? The TP_printk() has a
> "magical" trace_seq variable that trace events can use in the TP_printk()
> called "p".
>
> Look at:
>
>   include/trace/events/libata.h:
>
> const char *libata_trace_parse_status(struct trace_seq*, unsigned char);
> #define __parse_status(s) libata_trace_parse_status(p, s)
>
> Where we have:
>
> const char *
> libata_trace_parse_status(struct trace_seq *p, unsigned char status)
> {
> 	const char *ret = trace_seq_buffer_ptr(p);
>
> 	trace_seq_printf(p, "{ ");
> 	if (status & ATA_BUSY)
> 		trace_seq_printf(p, "BUSY ");
> 	if (status & ATA_DRDY)
> 		trace_seq_printf(p, "DRDY ");
> 	if (status & ATA_DF)
> 		trace_seq_printf(p, "DF ");
> 	if (status & ATA_DSC)
> 		trace_seq_printf(p, "DSC ");
> 	if (status & ATA_DRQ)
> 		trace_seq_printf(p, "DRQ ");
> 	if (status & ATA_CORR)
> 		trace_seq_printf(p, "CORR ");
> 	if (status & ATA_SENSE)
> 		trace_seq_printf(p, "SENSE ");
> 	if (status & ATA_ERR)
> 		trace_seq_printf(p, "ERR ");
> 	trace_seq_putc(p, '}');
> 	trace_seq_putc(p, 0);
>
> 	return ret;
> }
>
> The "trace_seq p" is a pointer to trace_seq descriptor that can build
> strings, and then you can use it to print a custom string in the trace
> output.

Yes I managed to decode the hidden variable :) I also found
trace_seq_acquire() (and its macro alter ego __get_buf()), which would
let me keep the generic stringer functions. So far, so good.

I think the foundational problem remains though: TP_printk() is not
executed until a user reads from the trace_pipe; at which point the
object referenced by __entry->info may already be dead and
buried. Right?

>> 
>> What I like about the current approach is that when new notification and
>> object types are added, switchdev_notifier_str will automatically be
>> able to decode them and give you some rough idea of what is going on,
>> even if no new message specific decoding logic is added. It is also
>> reusable by drivers that might want to decode notifications or objects
>> in error messages.
>> 
>> Would some variant of (how I understand) Steven's suggestion to instead
>> store the formatted message in a dynamic array (__assign_str()), rather
>> than in the tracepoint entry, be acceptable?
>
> Matters if you could adapt using a trace_seq for the output. Or at least
> use a seq_buf, as that's what is under the covers of trace_seq. If you
> rather just use seq_buf, the above could pretty much be the same by passing
> in: &p->seq.
>
> -- Steve
