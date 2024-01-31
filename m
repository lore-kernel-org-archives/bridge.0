Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E00E7B3D4
	for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705420; cv=none; b=ecgiranUop29rngG8GlnzXswTg8fGBTb7ZSfIwvkeNTv4xLx7rrFwtJCxu8wK/Vq344dAR30mDcDRO/0XrPJhU57UXtMLPQTX1xrxFQ+jIm9UgPtL0yBTZzXPK5FgAa7dnoWejInxT6UMNYdznye66zeiN0qwknjmsDfv8yarqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705420; c=relaxed/simple;
	bh=vdC/28mZ3AO42VX/8yIFFv1FKGdt7O1G/wt/UiG81Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V16BR1lOg45qN6bj1vIEIEu28VUUZtNNjIfPELM8TIruKozUDAlD8poGDsoOV+pvFbZbg27A3HsPMMP6h46DpwnujGkS/Ke6JnxUGINJ+jRL54kiQ29qZZGtpZpqgKl/loksbWs/ZjUyZcDJTQdTpfKJl3za3JQxhHBIQRO4Njk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=H64vVqvr; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="H64vVqvr"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-33aea66a31cso1991520f8f.1
        for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 04:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706705416; x=1707310216; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQN5M7XVgkAAlALJa5Q7p1kEHiTu8VHYsO5MNF4mfto=;
        b=H64vVqvr6K1IP+cNpE3y5DHUgdEUuEQDQuGtKQ89cu1qgwS3mBRCSVHZ95K8CGtCaN
         exGx+sRqtk2aXwaI9TzuH7hu3HEsy72MfSTfqz+vU+N2ZcAMwUaXMlKqwPPZRyG3WfcD
         ix3n0KPSxwN8DlJgyPThxK+gI1gEgurWJP7AI0fA6/64uZdkgiA/eN3EDW0vsaDh4Hhm
         CDcbKmEzAuMvdRFkNj2tpTTI/Bd97BoWvs6vOegPjImC9H+cv1O9ivLeLaL11c6LIp37
         B8krVcHCHXixN1ho09ahds4jSkBUv3VaFPIEEMQzKaTZYkT2EafGO5Vv5CHrdrygeuhW
         wzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705416; x=1707310216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQN5M7XVgkAAlALJa5Q7p1kEHiTu8VHYsO5MNF4mfto=;
        b=rQYF62zJd7aQ198skspVx7CDSaq8Hu0b4XR1lwKiQTCbIhcLCdCHJTZKgflfqXblhl
         ftU1qikl2Ar9KGkIC76d8niDUIQ+nUNxy3/S7BD9yUnLYAfPo7PpYCc9ARBghxJsAWNL
         OVY8KdVhdQirWfLYpqJRgqsMfag3PQxHVK+KFFxsxqMa+FlaRO6Yd0JzdH6bYlGN9nDz
         7fHf0aa/OazgvsWaRM/cJ4pVqpLwCdj0oppoBbeP3I+crDfevbEyro8XNRvbXBGcH2Y0
         XuNNcbtt0Lshfsoj3iC3h4m5uVwo/Pycka3IxQ/5WA2YQ3zOt1Orns8UHsu2Nsnh5H77
         6yMQ==
X-Gm-Message-State: AOJu0YxjsJuQDaP4JnhR5LWEThipiPGy1B1tjARh+6d4mWpai/zVYLg7
	tvjkC4JAdHIb+Kw9lY2VjIFArFkU/Cqg8BHg0DPK+51sTXGk3yBvwFpZXKabzHY=
X-Google-Smtp-Source: AGHT+IFxwTSaLVQj11Ax8Y9mO3ewQhvQoZSge3oeqveK0qDfAQJWX/w7EDrxTM4pIC7nXM96e+FuMw==
X-Received: by 2002:a5d:4dc9:0:b0:33b:1ff:f677 with SMTP id f9-20020a5d4dc9000000b0033b01fff677mr1177987wru.50.1706705415592;
        Wed, 31 Jan 2024 04:50:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVgrdks3MpfUEXYPHYxb76540xWWRviMQVg/CADGI0aAbYJNF8/c+u/kMzw0vkuszrkIhLd5LpxBvdUdsyu9Wvr47UTTEOAI9RgXQAJ86wmCDbdQkhrLlfw6TMwPnBebzr0T/D0DLEyWDvbCdAD4yFhhgLhCuhLLYApjni5AP/xXYL/KhufBQS2AONxW7spFcnaWJrmDeFe5naHACbXPwSaBxClkoQOrHXJ4wz0a93LMzDBxUGvrND1/Qw7DQFt1Fzb3K9b2daz5YQi7jK7CMA=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id cx16-20020a056000093000b00337d5cd0d8asm13335210wrb.90.2024.01.31.04.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:50:15 -0800 (PST)
Date: Wed, 31 Jan 2024 13:50:11 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, olteanv@gmail.com,
	roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
	netdev@vger.kernel.org, ivecera@redhat.com
Subject: Re: [PATCH net 1/2] net: switchdev: Add helper to check if an object
 event is pending
Message-ID: <ZbpCA3kgoCKsdQ4J@nanopsycho>
References: <20240131123544.462597-1-tobias@waldekranz.com>
 <20240131123544.462597-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131123544.462597-2-tobias@waldekranz.com>

Wed, Jan 31, 2024 at 01:35:43PM CET, tobias@waldekranz.com wrote:
>When adding/removing a port to/from a bridge, the port must be brought
>up to speed with the current state of the bridge. This is done by
>replaying all relevant events, directly to the port in question.

Could you please use the imperative mood in your patch descriptions?
That way, it is much easier to understand what is the current state of
things and what you are actually changing.

https://www.kernel.org/doc/html/v6.7/process/submitting-patches.html#describe-your-changes

While at it, could you also fix your cover letter so the reader can
actually tell what's the current state and what the patchset is doing?

pw-bot: cr


>
>In some situations, specifically when replaying the MDB, this process
>may race against new events that are generated concurrently. So the
>bridge must ensure that the event is not already pending on the
>deferred queue. switchdev_port_obj_is_deferred answers this question.
>
>Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>---
> include/net/switchdev.h   |  3 ++
> net/switchdev/switchdev.c | 61 +++++++++++++++++++++++++++++++++++++++
> 2 files changed, 64 insertions(+)
>
>diff --git a/include/net/switchdev.h b/include/net/switchdev.h
>index a43062d4c734..538851a93d9e 100644
>--- a/include/net/switchdev.h
>+++ b/include/net/switchdev.h
>@@ -308,6 +308,9 @@ void switchdev_deferred_process(void);
> int switchdev_port_attr_set(struct net_device *dev,
> 			    const struct switchdev_attr *attr,
> 			    struct netlink_ext_ack *extack);
>+bool switchdev_port_obj_is_deferred(struct net_device *dev,
>+				    enum switchdev_notifier_type nt,
>+				    const struct switchdev_obj *obj);
> int switchdev_port_obj_add(struct net_device *dev,
> 			   const struct switchdev_obj *obj,
> 			   struct netlink_ext_ack *extack);
>diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
>index 5b045284849e..40bb17c7fdbf 100644
>--- a/net/switchdev/switchdev.c
>+++ b/net/switchdev/switchdev.c
>@@ -19,6 +19,35 @@
> #include <linux/rtnetlink.h>
> #include <net/switchdev.h>
> 
>+static bool switchdev_obj_eq(const struct switchdev_obj *a,
>+			     const struct switchdev_obj *b)
>+{
>+	const struct switchdev_obj_port_vlan *va, *vb;
>+	const struct switchdev_obj_port_mdb *ma, *mb;
>+
>+	if (a->id != b->id || a->orig_dev != b->orig_dev)
>+		return false;
>+
>+	switch (a->id) {
>+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
>+		va = SWITCHDEV_OBJ_PORT_VLAN(a);
>+		vb = SWITCHDEV_OBJ_PORT_VLAN(b);
>+		return va->flags == vb->flags &&
>+			va->vid == vb->vid &&
>+			va->changed == vb->changed;
>+	case SWITCHDEV_OBJ_ID_PORT_MDB:
>+	case SWITCHDEV_OBJ_ID_HOST_MDB:
>+		ma = SWITCHDEV_OBJ_PORT_MDB(a);
>+		mb = SWITCHDEV_OBJ_PORT_MDB(b);
>+		return ma->vid == mb->vid &&
>+			!memcmp(ma->addr, mb->addr, sizeof(ma->addr));
>+	default:
>+		break;
>+	}
>+
>+	BUG();
>+}
>+
> static LIST_HEAD(deferred);
> static DEFINE_SPINLOCK(deferred_lock);
> 
>@@ -307,6 +336,38 @@ int switchdev_port_obj_del(struct net_device *dev,
> }
> EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
> 
>+bool switchdev_port_obj_is_deferred(struct net_device *dev,
>+				    enum switchdev_notifier_type nt,
>+				    const struct switchdev_obj *obj)
>+{
>+	struct switchdev_deferred_item *dfitem;
>+	bool found = false;
>+
>+	ASSERT_RTNL();
>+
>+	spin_lock_bh(&deferred_lock);
>+
>+	list_for_each_entry(dfitem, &deferred, list) {
>+		if (dfitem->dev != dev)
>+			continue;
>+
>+		if ((dfitem->func == switchdev_port_obj_add_deferred &&
>+		     nt == SWITCHDEV_PORT_OBJ_ADD) ||
>+		    (dfitem->func == switchdev_port_obj_del_deferred &&
>+		     nt == SWITCHDEV_PORT_OBJ_DEL)) {
>+			if (switchdev_obj_eq((const void *)dfitem->data, obj)) {
>+				found = true;
>+				break;
>+			}
>+		}
>+	}
>+
>+	spin_unlock_bh(&deferred_lock);
>+
>+	return found;
>+}
>+EXPORT_SYMBOL_GPL(switchdev_port_obj_is_deferred);
>+
> static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
> static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
> 
>-- 
>2.34.1
>
