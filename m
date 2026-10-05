Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375214ACC7A
	for <bridge@lists.linux.dev>; Mon,  5 Oct 2026 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211212; cv=none; b=sUgHUqzvJAHl/ozUW8UB4nwaygpshS27VRcVfalK0pquCIYTuQB2nkc1FdUFxIlZpG3Zh6FWPDzmvjURj6xTDYsX/43ZbdTSE4EYR6f2VFp0+w82mDtGCOadfhPbEPYgFziYyshlOW56NzPfgha5gh/VHrSQ9SSg+9P6zDFCN88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211212; c=relaxed/simple;
	bh=7prVsLcxC5euibeO10biFrGSkYTV8r8zEoYUDnCIDAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHZTlW3JV8RIk33R4RRENT8WhzmpeKNwHo0JeRdsjf2/Z5FzamFZvXccMeQwnny6gl/u9LqO5+8vXXg77aLexUSmMTxMnPjwaAGTGHpbrG4MB7AGgkWHEykGJ1/Z3ISfNh6oJuA4oEwW2zKF0Ldhu5j7EenLY/kj0EqDssiOZN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=RI4OEN9c; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="RI4OEN9c"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49ff680331aso18656465e9.3
        for <bridge@lists.linux.dev>; Mon, 05 Oct 2026 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1791211196; x=1791815996; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9j6IEIFgBzPxK946Me+Dgw49Jbt2Vury8puH8M1Nww=;
        b=RI4OEN9c+8Ij44Ow4zYM9AsFaau2pP3flqDtpOYba/+q4qct5rwz/dBEeTpZggoPAf
         0zHkco8ewYbusO6RG6IfPGMf8ThUxjoxQPvfScvBha9KQiKwQ72D7irFnhrZF82EokZs
         ymLnwVjgZlAFiHCxLLJjd3sIhyaV8hDvy5Qpis4AnX084eNzklep1ZLfbenL8Rwql4ou
         jUeIBydSLU/dJd0APZZjE1WvaSaAt3YAseA59ESdAuRTu8JJZAEQ+bDwwlN/+Gj1bu3U
         yi+RUOy1B0FjBy1YYMneaEX3pvitX4LB/os9dW7znRp3DtmVN+vSimfHc7vCaFApOcD6
         OnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211196; x=1791815996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x9j6IEIFgBzPxK946Me+Dgw49Jbt2Vury8puH8M1Nww=;
        b=lZQFN/fXMO2+Re06cD1Z6FoCN3ttybvy9SI8R9hYLFl5m7JLkqr8ZcDnrUI/r5+m3p
         z8oh1dmsTvlDa9hD2ks6lez9xUknWyvVTwUQY5OoyH9o3rNifn/2wAIHNiQ6iiXi4kQc
         MYPCuPZ9z3ETQLw8TbyBjG8qS0RDamJd1o3SLmNoXF8fXyIvLJlpkEd5b0YqkW2xaL7s
         1XLIrPi553+/ZbI9fKsAbXrGbv3TS02E4DVr0NyySIE1/WKLBV7S8vNnWceyyUusf5Hs
         HcBqN9JIyAtrdL/8fK/Uc8w16ygT21TvOyZI8suDlLmtre/CzMqFA6MtgQWQy9hiiqiW
         3tqg==
X-Forwarded-Encrypted: i=1; AKwUvBwl8DrSGlDD8HGYZmEEr8yAgKjNaZgg+0WLMUvorsEVfOeIJB0ZAlSNFGMGbk4qfiNb3hvevzE=@lists.linux.dev
X-Gm-Message-State: AFuF++kzuWbQ9493+pmT5UWOqALNKM2idOQf+XnMy8XKojgFGWOhHY8i
	5gr6hoc6rkXPVU576h+2u7Gzl7CVO8KhKwLECZuSiwHD6C21A9LvIxbKuRCoQgBPhyiLEekBJ3M
	sMLow
X-Gm-Gg: AYBFou3v7m2puu2OHYJFMbKSa50REsuvTjwxt53xAD0LhdqJJvT3M1t7Y+6pmMNR+TV
	NPXweVZD+raQXmN/qZ07z9crLvsWUn+b8uPXO2qvVhKwkBNdfSxa1GFo3LGKj08boHih2AczH8X
	CYONxPpdplH9OcqnAy2vo4HLddmyrPZetTITqvFY2VBUSj76/P8Yi6r0JNJ7UKTsUwQW4ajJvNv
	McXgBYkrr334C2rwcMfUyuOQHqIkdNZOMx3n+zjs7HneoqpSmt1R53ws7Py7y9uVaLnUP1zVTK8
	zxiF+z0/PbH4+ZmI7LTn8Iqe52M0N7jGjz45Z4fy2mgHRmLC8IFRgNrdjRClQ5UN0Xi4l7LopWs
	MoHJLHbRRS7Wa6cgqwq1lTP/JizIKRE/8Ugwlg5e1aag7bOeMKgwGf+imJoglSXI3B7+8JNbNvx
	oqpHED/Bl7LnHLG/JEJzRWBNipEbtLT9CFiyDVSKE1l+loSK3zxFMv5Kw9h1vDTDcBuoxiot1q5
	0gcQVPGagI3bBYpYRUg
X-Received: by 2002:a05:600c:c4aa:b0:4a0:5b:7bc0 with SMTP id 5b1f17b1804b1-4a1680f7780mr137106015e9.21.1791211196470;
        Mon, 05 Oct 2026 07:39:56 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a03ff56136sm135003335e9.3.2026.10.05.07.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:39:55 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 2/6] net: bridge: fdb: update the comment for br_fdb_cleanup_by_dst
Date: Mon,  5 Oct 2026 17:39:33 +0300
Message-ID: <20261005143937.877466-3-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005143937.877466-1-razor@blackwall.org>
References: <20261005143937.877466-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the comment for br_fdb_cleanup_by_dst to better reflect what it is
doing after the recent changes.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_fdb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 730b178cf6c4..ce09e3fbc58b 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -868,9 +868,11 @@ int br_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 	return 0;
 }
 
-/* Clean up all entries referring to a specific destination.
- * if do_all is set also flush static entries
- * if vid is set delete all entries that match the vlan_id
+/* Clean up entries referring to cleanup_dst's port.
+ * If do_all is set ignore vid and entry flags. Otherwise vid selects
+ * the VLAN (0 means all), keeping static and non-offloaded ext learned entries.
+ * For a port-VLAN dst, vid must match its VLAN ID. Always clean up its local
+ * entry unless user-added and fall back to the port dst for retained entries.
  */
 void br_fdb_cleanup_by_dst(struct net_bridge *br,
 			   struct net_bridge_dst cleanup_dst, u16 vid,
-- 
2.47.3

