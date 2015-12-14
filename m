Return-Path: <vel21ripn@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject
	:content-type:content-transfer-encoding;
	bh=gNyppQMYg/oEw5tKnQz88x6sIIkJKbng79+n+qAFV+E=;
	b=tOuGFkZZON9rza9kOzxBFGzEzRWSdyrxK1nbi7B5hDKo6acgiIq1vny44YQ9ifHFaY
	EbGSotijJTTfvVSM/ZMXVNTWYXM+slg9s7Sre6c0jgAbWxSjZ+AWWSerzhZrn/sByMZq
	Kr9HaBjFAIEyUVIZChD9fFNF1FYm1VY9p3PLAREyZc1JylfSb+BOjLZdsH46GSOvS4HB
	N0e5nDwsD4CUR4z1V6Gh8JlMia9NL+HeO9Eppp6+7tgA+kWHzjv9ezd9ZXKlMlREfeqT
	Jsk4Ix/KBRfpUJaC4WE3J+tNcjJ8KKL5S/oapaHvVF5KWq9cJqMizTxpHv1q2Od02+aL
	F/qw==
Message-ID: <566F16C7.9060808@gmail.com>
Date: Mon, 14 Dec 2015 22:21:43 +0300
From: Vitaly Lavrov <vel21ripn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [RFC] The problem with the mirrored traffic: setageing 0
	not work
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi!

After commit c62987bbd8a1a1664f99e89e3959339350a6131e (bridge: push bridge setting ageing_time down to switchdev)
impossible to handle mirrored traffic through netfilter and it is impossible to transfer it to a virtual machine.

The problem code is net/bridge/br_stp.c:br_set_ageing_time() line 580
---------------------------------------------------------------------
570 int br_set_ageing_time(struct net_bridge *br, u32 ageing_time)
571 {
572         struct switchdev_attr attr = {
573                 .id = SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME,
574                 .flags = SWITCHDEV_F_SKIP_EOPNOTSUPP,
575                 .u.ageing_time = ageing_time,
576         };
577         unsigned long t = clock_t_to_jiffies(ageing_time);
578         int err;
579
580         if (t < BR_MIN_AGEING_TIME || t > BR_MAX_AGEING_TIME)
581                 return -ERANGE;
582
583         err = switchdev_port_attr_set(br->dev, &attr);
584         if (err)
585                 return err;
586
587         br->ageing_time = t;
-----------------------------------------------------------------------

To handle the mirrored traffic we must have ageing_time = 0.
IMHO check aging_time need to move in ops->switchdev_port_attr_set().
If it is a hardware switch and it has restrictions on ageing_time, then it must return -ERANGE.
For a software implementation of a switch(brigde) we can allow the special value "0" ageing_time.


The second problem is in the line 584 - Do not check the error code "EOPNOTSUPP"
This line must be  "if (err && err != -EOPNOTSUPP)"

How better to done in such situation?
