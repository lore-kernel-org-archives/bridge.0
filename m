Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DD5483BC7
	for <bridge@lists.linux.dev>; Tue, 15 Sep 2026 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460792; cv=none; b=Xk/eBlrqQFWQvJpL5NL7DvJ2ekNhmaHsXHOLrGoWdSO68CSC9ycQ4EjRN+93y46G8Jp/6XKoR445k3stE+9rcp37n7R2xEpXJr9rWC3eCIz0bAxCkYe3Dmjg5/qSDLbVnakqe3jN5zFgTT88Sv5aUe60S2NxmaB//fYgvKiDmdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460792; c=relaxed/simple;
	bh=7vU8bMonAZkxVqIAInFyLMmd0cCGJtePl7fRCKcr+5o=;
	h=From:To:Subject:MIME-Version:Date:Message-Id:Content-Type; b=qnSgZGXXEaiNxQH7E5L9Om4M9po5v/jRm2i4vlM+/5EEMfk4yL/MaJs36j8HoexKN5TmP11UUiVa/QsB0WAzvZKSa0Sp9AMaAhucZo2JxMVQg79tE6c2c5gNglEOBk2s+ngg71jTnTyzki5/PK6NT2VLxXsCeInVdMNeuCojfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=K2zCOnAU; arc=none smtp.client-ip=178.154.239.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="K2zCOnAU"
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward200b.mail.yandex.net (postfix) with ESMTPS id E070284C43
	for <bridge@lists.linux.dev>; Tue, 15 Sep 2026 11:23:25 +0300 (MSK)
Received: from mail-nwsmtp-mxback-production-main-40.sas.yp-c.yandex.net (mail-nwsmtp-mxback-production-main-40.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1e:4911:0:640:4f4:0])
	by forward103b.mail.yandex.net (postfix) with ESMTPS id 49B7DC007E;
	Tue, 15 Sep 2026 11:23:18 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c24:1726:0:640:f778:0 [2a02:6b8:c24:1726:0:640:f778:0])
	by mail-nwsmtp-mxback-production-main-40.sas.yp-c.yandex.net (mxback) with HTTPS id ENPo3J0xkmI0-6V9IxMWg;
	Tue, 15 Sep 2026 11:23:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1789460597; bh=T8pfusannTcyvHRvaFJ/4uYqL4WOXDp4p0rDFOjPFd0=;
	h=Message-Id:Date:Subject:To:From;
	b=K2zCOnAU/DDWnGFyoGJHwXF3t5F3HVdWWK9x54Dt4RkMsPFefQ5smogAg3uN4PLi/
	 k8tQbB7VytaDaTRZUKbZ9DXmIyrIhOrAU7jxyfeI8cVduZCOOzl4TFy/3FFqP3sxEj
	 GQ9UPxcp7gks5JGdCxOSTRJjnHFUCHaTVNjsKZUA=
Authentication-Results: mail-nwsmtp-mxback-production-main-40.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
Received: by mail-sendbernar-production-main-35.sas.yp-c.yandex.net (sendbernar) with HTTPS id eb480002f35d61b4fd5b45c77bc63bba;
	Tue, 15 Sep 2026 11:23:17 +0300
From: =?utf-8?B?0JDQu9C10LrRgdC10Lk=?= <ioctl@ya.ru>
To: razor@blackwall.org,
	idosch@nvidia.com,
	bridge@lists.linux.dev
Subject: [PATCH bridge] Allow MSTI 0 state setting the same way as non-zero MSTI
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 15 Sep 2026 11:23:17 +0300
Message-Id: <4150481789460597@ddf99c15-6b70-4f37-97c6-5b57e045b15b>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Hello!

For now kernel rejects setting MSTI 0 instance state in the same way as another instances.
I.e. any non-zero instance state can be set with the following command:
# bridge mst set dev <dev> msti <instance> state <state>

While MST 0 instance state cannot be set in the same way and requires another command:
# bridge link set dev <dev> state <state>

This look a little bit inconsistent.
The following change fixes it:

---
Allow setting the MSTI 0 state the same way as non-zero MSTI. 

Signed-off-by: Aleksey S. Kazantsev <ioctl@yandex.ru>

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 43a300ae6bfa..852e21b88c69 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -112,14 +112,12 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
        if (!vg)
                goto out;
 
-       /* MSTI 0 (CST) state changes are notified via the regular
+       /* MSTI 0 (CST) state changes are also can be notified via the regular
         * SWITCHDEV_ATTR_ID_PORT_STP_STATE.
         */
-       if (msti) {
-               err = switchdev_port_attr_set(p->dev, &attr, extack);
-               if (err && err != -EOPNOTSUPP)
-                       goto out;
-       }
+       err = switchdev_port_attr_set(p->dev, &attr, extack);
+       if (err && err != -EOPNOTSUPP)
+               goto out;
 
        err = 0;
        list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
@@ -294,7 +292,7 @@ int br_mst_fill_info(struct sk_buff *skb,
 
 static const struct nla_policy br_mst_nl_policy[IFLA_BRIDGE_MST_ENTRY_MAX + 1] = {
        [IFLA_BRIDGE_MST_ENTRY_MSTI] = NLA_POLICY_RANGE(NLA_U16,
-                                                  1, /* 0 reserved for CST */
+                                                  0,
                                                   VLAN_N_VID - 1),
        [IFLA_BRIDGE_MST_ENTRY_STATE] = NLA_POLICY_RANGE(NLA_U8,
                                                    BR_STATE_DISABLED,
--

Aleksey Kazantsev
