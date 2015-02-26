Return-Path: <tomasz.wisni3wski@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to:content-type;
	bh=xwG6Y+bTSPmh50DxmqM2Mlux9wq8u8noWJ/4p1w31DY=;
	b=CKDkM9YhD/2emQ2D95kqlSYBuWp/N2zkcKGKOSQkFkA3omDQnxV+MdmMyZBppfdPtW
	ZWbOy4W8EbuQMEGo/uIeH/a2lyoG4qIJqBNZKYvi2zhLXBksWzjusHleVGBdtxkwwrg/
	b9jZ8q+R9UYYz4MoPCb/sZsWFiJ9Rts1YBhTQCmHC92zKWI/2r0/45gwDA2ri5ALihf5
	Yiisg4wS4DAdHrKGNVy8e2z3OK6ua+2FCsjEkrX9Ee7+KL0M339ydeShuSlZ+JhoWrgR
	gRV/QQhdPW6Oc+Hfs86RHTq8hEEMPcM9i+qYN9BgPCOmexBaZxW9dcLff/sKMokfyGgc
	kVWg==
MIME-Version: 1.0
From: Tomasz Wisniewski <tomasz.wisni3wski@gmail.com>
Date: Thu, 26 Feb 2015 11:02:38 +0000
Message-ID: <CABAf95oekaL5cUnOZ3TYH4sEi6tHPYCZ11B8+ZF2qAnV3qNsQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Bridge] net_bridge_port net_device NULL
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

I'm dealing with a strange problem and not sure if it's appearance
indicate a problem with a forwarding database or this is the case
where a custom patch is misbehaving.

Can an entry (net_bridge_fdb_entry) exist in the fdb containing
net_bridge_port (dst field) which net_device (dev) is NULL ?

This seems very strange. I went through the code and the
net_bridge_port is always created in association with a net_device.

Are there any circumstances under which the net_device of
net_bridge_port may become NULL ?

-- 
Pozdrawiam / Best Regards

Tomasz Wisniewski
