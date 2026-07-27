Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35115E5BB
	for <bridge@lists.linux.dev>; Mon, 27 Jul 2026 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175795; cv=none; b=dixbs9uoKrehmirzfursw5vep01F2brHXYZ/U/dA+tRnGs6slKUmehAV+dfvzLBaC//Bn9NT3KqKdqWb6glrkCniEJfuwXF7kmEGOgrqOlkoRKPSUWoRsWoHmf1DZoFye2MEh3H/Bl4k5MgAicQnV90mUy4806eifKGkcw/hJa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175795; c=relaxed/simple;
	bh=OLBdS9U6vXN7yMZfsPU6bymQTHU8wKH/nuh7cA8y5KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJULV6Tnozdft0+RnL2C6jYMS/p5f2IyxyOMlOM5WBnWMD15dqyYFLxa/bGvyyIwzJB0V85RUcC+n6JO8IXPmA5I9GoSbT+S2J11voBZc2f0asn6RpkxIs6V/1f9KgurBCtpEZGh7YLMEyCu6/nySjvFOJpYcUnHmI7pcn7Ml3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJRUce88; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJRUce88"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8486672f03cso2976128b3a.0
        for <bridge@lists.linux.dev>; Mon, 27 Jul 2026 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785175794; x=1785780594; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uLODgO01cDfV9ff6XhKqu+PMyWRibmT2eT2umzWtrJY=;
        b=ZJRUce88/IxmGlmeVUMI/kl2ZD36dd28usa45C34gvqCIy1EmY9/TGhNR/2kuFtEJz
         m73K2X/ol5BBPJqkxNUkpyTUY8/jPm/eIBuA8WELF5V1sgKEncRyjKH6ahXTdAhcl6xI
         Hfa1RpvSAAfDHt3/mmKCBKjti1cyg6yPRZxXZUouzhz5/Kz3/WS+OPK2byhb7YQQ9cLG
         W+eQ4FzbmWID5jTBX0fDKknod9VtAbM1h5xnUpicWfRAJRAhzfFv+/+TGA5K+Kbu3AxV
         8+5xLJl8QTVFudA2joh4nKAcWW/CgLpLJHETz6OubpNn8GyWZZhCY6f1yrlKHVOaOrKl
         21AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785175794; x=1785780594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uLODgO01cDfV9ff6XhKqu+PMyWRibmT2eT2umzWtrJY=;
        b=n/8V1ARVsc9qBExAJZs2Q6NmKsq+xjlvokF4RvKYelQ/VK1E/eEJaq4nhXs5RVTIPR
         PqrWbtbde19jrB6/o1UiNJTmL8SdocReAez8ZmIuTudK+Y8GH3PSqRrMaAp1l8Em7043
         gMSmJp87E37/3gyPcb5+/lbCd+yybTT4uOoO3xwRm+gUPVkBRUGyFCH2ax2g3QlWp5rA
         ssjmGU1ylR3VBEVegbL0eQuJhAO3auG5IFJejZFNWlw3rIMXNroatpofcjPZA7ZzJmrY
         xVPE3D5c6YDx/kFSExze5eDbr+9VsuRokp+ENAfYnEQvZ4qSdRVz+FiRDjCw1T5DdwkF
         6TaA==
X-Forwarded-Encrypted: i=1; AHgh+RqIzMtC3fNYiyA0VrnpMULlDnvOL9p79FqPFGnD1xa7vkNZc0iWgk1cSKxn2KycXy3cdnO+C5g=@lists.linux.dev
X-Gm-Message-State: AOJu0YxV9NdxRgexRssaiFOZ+UkrstSEC8gQo1sLLen5kmaey2ubSVAE
	aYM5UcTgMH6aUGZQDJX4ymJ2qslxYAo/FT4L6F2XeHdmqqfh0eTo27Yu
X-Gm-Gg: AR+sD12+IWap/swiqj0GZ+5I2Kf0YROpsTWrRp0uI3iA59nHlEeiEDXwRj/zVzzbo+v
	pG8HexKP+4yhGkNSTP9bis8+csl98Bv3e+5a1KBEYpEFWx5K92bIoxDhdljvAo0fgGCa9dOLa5S
	8HoTpkOebgM5iJFejADQpXeIi+L3fJFAAQwqsgSRqdTHDm9pRmpW/amNURNRdZvId84iZKs/6hM
	8apRPydRi9T6bNH7JNLIIgh4ekYq5Zhu2m8nCAzpeROPdMa3VeR1dHyd7VKyk7u/JKaohlobnd0
	HxNii5ZDbXk2jGvleJDT7SGkM5v2UKF8JbuVbxTEFJzy6eOy4aNvrsgo+Ulau3u9H3FzcPYPA5t
	TvEax0PUp+Gvw5RQH3cDhLxzq7BWGcY6/kJKp8GrSvAPg5gM0bvv6N4E5bof6vwywvqk8eOJ0k9
	xkjZwiUEXkyDWGJFtGLn5R
X-Received: by 2002:a05:6a00:a586:b0:83e:b443:965e with SMTP id d2e1a72fcca58-84e5940aefbmr8409625b3a.3.1785175793794;
        Mon, 27 Jul 2026 11:09:53 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5343a9c6sm3494198b3a.51.2026.07.27.11.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:09:53 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	razor@blackwall.org,
	idosch@nvidia.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH nf 1/1] netfilter: ebtables: avoid unbounded counter allocations
Date: Tue, 28 Jul 2026 02:09:44 +0800
Message-ID: <783a8ef151994345c0c251b5d31a1acb425f8d34.1785131981.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1785131981.git.zihanx@nebusec.ai>
References: <cover.1785131981.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

EBT_SO_SET_COUNTERS copies only the fixed ebt_replace header before
calling do_update_counters().  update_counters() checks the user supplied
length against the user supplied num_counters, but do_update_counters()
then allocates the temporary counter array before it looks up the table
and before it compares num_counters with the table's real entry count.

EBT_SO_SET_ENTRIES has the same issue when userspace asks for the old
counters back.  do_replace_finish() used repl->num_counters to allocate
the temporary counter array before it looked up the table and before it
validated repl->num_counters against t->private->nentries.

A caller with CAP_NET_ADMIN in its network namespace can therefore pass a
large num_counters value and force a multi-gigabyte vmalloc attempt even
when the named table does not exist or the counter count does not match
the table.  The request is rejected only after the allocation attempt.

Look up the table and validate num_counters against t->private->nentries
before allocating temporary counter arrays.  This keeps valid counter
updates and replacements unchanged while bogus table names and
counter-count mismatches are rejected before any user-sized counter
allocation is attempted.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/bridge/netfilter/ebtables.c | 34 ++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 96c9a8f57c87..81496ebf92a9 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1017,16 +1017,6 @@ static int do_replace_finish(struct net *net, struct ebt_replace *repl,
 	struct ebt_table_info *table;
 	struct ebt_table *t;
 
-	/* the user wants counters back
-	 * the check on the size is done later, when we have the lock
-	 */
-	if (repl->num_counters) {
-		counterstmp = vmalloc_array(repl->num_counters,
-					    sizeof(*counterstmp));
-		if (!counterstmp)
-			return -ENOMEM;
-	}
-
 	newinfo->chainstack = NULL;
 	ret = ebt_verify_pointers(repl, newinfo);
 	if (ret != 0)
@@ -1053,6 +1043,15 @@ static int do_replace_finish(struct net *net, struct ebt_replace *repl,
 		goto free_unlock;
 	}
 
+	if (repl->num_counters) {
+		counterstmp = vmalloc_array(repl->num_counters,
+					    sizeof(*counterstmp));
+		if (!counterstmp) {
+			ret = -ENOMEM;
+			goto free_unlock;
+		}
+	}
+
 	/* we have the mutex lock, so no danger in reading this pointer */
 	table = t->private;
 	/* make sure the table can only be rmmod'ed if it contains no rules */
@@ -1386,25 +1385,27 @@ static int do_update_counters(struct net *net, const char *name,
 			      unsigned int num_counters, unsigned int len)
 {
 	int i, ret;
-	struct ebt_counter *tmp;
+	struct ebt_counter *tmp = NULL;
 	struct ebt_table *t;
 
 	if (num_counters == 0)
 		return -EINVAL;
 
-	tmp = vmalloc_array(num_counters, sizeof(*tmp));
-	if (!tmp)
-		return -ENOMEM;
-
 	t = find_table_lock(net, name, &ret, &ebt_mutex);
 	if (!t)
-		goto free_tmp;
+		return ret;
 
 	if (num_counters != t->private->nentries) {
 		ret = -EINVAL;
 		goto unlock_mutex;
 	}
 
+	tmp = vmalloc_array(num_counters, sizeof(*tmp));
+	if (!tmp) {
+		ret = -ENOMEM;
+		goto unlock_mutex;
+	}
+
 	if (copy_from_user(tmp, counters,
 			   array_size(num_counters, sizeof(*counters)))) {
 		ret = -EFAULT;
@@ -1422,7 +1423,6 @@ static int do_update_counters(struct net *net, const char *name,
 	ret = 0;
 unlock_mutex:
 	mutex_unlock(&ebt_mutex);
-free_tmp:
 	vfree(tmp);
 	return ret;
 }
-- 
2.43.0
