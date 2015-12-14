Return-Path: <oliver.graute@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=ApVTDpHXk8cw0ItnIteW4pCjmDd/T8tZpRyJd3p75jg=;
	b=RKKGbBf+PJqPX7ze+bM4c44ElOXPmMwF+aDAqxnUE+T/I8xrwIsSZrZuR3ht+LhHB+
	tVOYJ8FPhyRX3J7EQP3E+SWceurLIPWfbivvDYhJh/IoNO2Q/9V6KiBMnRa4oOIdZ8Um
	CYTtY3buDQpClHmfiQ83BYcc8TnP65ZsO5u7k3vPJJOafFRDxivWfYI/BRLmJ9SncYHa
	/JQccU0ik/VTiADaB0pxJ3qsWKYCC1kul0dAqA59s2RVfTfTpqge1crZnUBOF+YXuYRs
	2I9cpHp7Pcy4Vyin6wtRXbdPbNGDOjV+p71RKl+Bh7iGJG7/a3VYmDoGnr+6hQ8XNldx
	cdKw==
MIME-Version: 1.0
Date: Mon, 14 Dec 2015 15:05:26 +0100
Message-ID: <CA+KjHfbJyF-RqqTYoh6=X7KpPTo-==T14wpn=+2oduDy=S3+xw@mail.gmail.com>
From: Oliver Graute <oliver.graute@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Bridge] adding a vlan interface to a bridge interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello,

I try to add a vlan interface to a bridge interface.

But in the moment I add the eth1.4 vlan interface to the br0 Interface
icmp pings to another host in the same vlan aren't working anymore. In
tcpdump I see some arp request/reply come through. But no ping reply.


brctl addbr br0
brctl addif br0 eth1.4
ifconfig br0 192.168.1.1 up

brctl show
bridge name     bridge id               STP enabled     interfaces
br0             8000.00604cc70004       no              eth1
                                                        eth1.4

I tried to configure this kernel parameter

/proc/sys/net/bridge/bridge-nf-filter-vlan-tagged = 0

but with no effect.

if I remove the eth1.4 interface from the bridge the icmp pings are
working again. I do not understand why, can somebody point me in the
right direction?

I should mention that I am using an older 3.9.11 kernel for this.

Best regards,

Oliver
