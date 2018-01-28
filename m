Return-Path: <adrian27oradea@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=lqpx7K3bqPPe6s1TBNnTKwrzKzNsOcQf16Ic4NAHBM8=;
	b=q8zWlU91lvV8+F92tTNH3PaE+sCo0mNqz+yzQsSbFfkFUE6wX32Oi2eC84fH1Y/jh9
	bwHlkr0FgbdqFevZZUhGc1wonEaGVrOhlO0RmGqb0v2XYm0HnD5pHRFhezjZrQ5tjIg3
	chqr45WEOAmUxfR+xVMyhESxV3N270xrsDL8s9JpFRoGHceEaW2BQM9Ytuc57udVdeFf
	4yNzkA0Vt/jGDuNtPUl4JwoJq8mllFpaFdjMtfxipp08EZb3qs4HcAquIDSeNp41FdDF
	dTGntBlpyhlXz6JVRfxWdoJaHWI865Vqq9jvbLRvJBOuNUa6yKu7jSMrBxC/vJejfYp6
	i63A==
MIME-Version: 1.0
From: Adrian Pascalau <adrian27oradea@gmail.com>
Date: Sun, 28 Jan 2018 22:15:34 +0200
Message-ID: <CA+k9h3O2OFKjoPqhN4LBnMODX=M607nwGfLiaAm+BB4T4mmEDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Bridge] ssh connection not working when ssh server is behind a
	linux bridge
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

I have a strange issue with a linux bridge and a openssh server
running in a VM connected to that bridge. Basically when I ssh with
Putty or any other windows based ssh client to an openssh server
running in a centos VM connected to the external network through a
linux bridge, the ssh connection hangs before the login prompt is
shown.

What I have learned is that when an Ethernet frame that is less then
60 bytes in size goes through the network, it is padded with 0x00
bytes until it has 60 bytes in length (64 with the frame check
sequence). When this kind of padded Ethernet frame goes from the
openssh server in my VM through the linux bridge to a windows host
where the Putty ssh client is, the IP and TCP headers in those frames
wrongly consider the 0x00 padded bytes as part of the IP / TCP user
data, therefore the upstream protocol (SSH in my case) tries to
interpret them, and the ssh session hangs.

My understanding is that those 0x00 padded bytes are at the layer2
Ethernet frame level, and should not be considered in the user data of
the higher level protocols. About the padding bytes I have found some
info here: https://wiki.wireshark.org/Ethernet#Allowed_Packet_Lengths

So I suspect this behavior is caused by the linux bridge, because
without the linux bridge, the ssh connection works without any issue.
What I mean is that if I ssh to the host operating system, the ssh
connection works without any issue, however if I ssh to the centos VM
that is running in that host operating system and that uses the linux
bridge for external network access, then I have this behavior that I
describe above. With other words, only when the linux bridge is in the
path of the ssh packets, this issue happens.

Now, my centos VM where I have this ssh issue is managed by libvirt,
and the bridge is in forwarding mode and created by hand. If the same
centos VM is migrated into an all-in-one OpenStack Pike host, where
the bridge is managed by neutron, the ssh connection works again
without any issue. In all cases I am talking about the latest centos
openssh server, and the default ssh server configuration file.

So, what do you think? Where should I look further to understand what
exactly causes this behavior?

Many thanks,
Adrian
