Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=nAm43dyYpPSRE5hX7zf6ZU3hrgm+IYQJ7x+V3zj9M5w=;
	b=ztySRT9i66GCJqUOwHwvLBbxvaB3KKqntDP6zj90R0T2gorZWeOADtArKFhJboz1Y5
	LK1fEq3xsMaz9A9eXAn/+uIRkHjn0R636n7Rk13iTyj1AKftAZgbY03D6JX7SHa7yJM2
	rAAg+vj9nG1fK/Q7YrMS/XM5qYRt8/ji0HKW61HAt4GxNlDK4CgQHFxHk/SCiXkDde9m
	bbmlP3Grjz4YgZ5pA98Z/UDA1+p/qmhjziKQO+vz3DzLG+Gmvodmt+cVt68y01u1yrpt
	EE1+3WSdNqGYcQf32G6qEzOxTjiMF7RVhmGxFp78+OMwKY7DCsei4qJ5GYyVHNrlHVBZ
	2IOA==
Date: Sun, 28 Jan 2018 14:28:26 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180128142826.15c9fcbf@xeon-e3>
In-Reply-To: <CA+k9h3O2OFKjoPqhN4LBnMODX=M607nwGfLiaAm+BB4T4mmEDw@mail.gmail.com>
References: <CA+k9h3O2OFKjoPqhN4LBnMODX=M607nwGfLiaAm+BB4T4mmEDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] ssh connection not working when ssh server is behind a
 linux bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Adrian Pascalau <adrian27oradea@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Sun, 28 Jan 2018 22:15:34 +0200
Adrian Pascalau <adrian27oradea@gmail.com> wrote:

> Hi,
> 
> I have a strange issue with a linux bridge and a openssh server
> running in a VM connected to that bridge. Basically when I ssh with
> Putty or any other windows based ssh client to an openssh server
> running in a centos VM connected to the external network through a
> linux bridge, the ssh connection hangs before the login prompt is
> shown.
> 
> What I have learned is that when an Ethernet frame that is less then
> 60 bytes in size goes through the network, it is padded with 0x00
> bytes until it has 60 bytes in length (64 with the frame check
> sequence). When this kind of padded Ethernet frame goes from the
> openssh server in my VM through the linux bridge to a windows host
> where the Putty ssh client is, the IP and TCP headers in those frames
> wrongly consider the 0x00 padded bytes as part of the IP / TCP user
> data, therefore the upstream protocol (SSH in my case) tries to
> interpret them, and the ssh session hangs.
> 
> My understanding is that those 0x00 padded bytes are at the layer2
> Ethernet frame level, and should not be considered in the user data of
> the higher level protocols. About the padding bytes I have found some
> info here: https://wiki.wireshark.org/Ethernet#Allowed_Packet_Lengths
> 
> So I suspect this behavior is caused by the linux bridge, because
> without the linux bridge, the ssh connection works without any issue.
> What I mean is that if I ssh to the host operating system, the ssh
> connection works without any issue, however if I ssh to the centos VM
> that is running in that host operating system and that uses the linux
> bridge for external network access, then I have this behavior that I
> describe above. With other words, only when the linux bridge is in the
> path of the ssh packets, this issue happens.
> 
> Now, my centos VM where I have this ssh issue is managed by libvirt,
> and the bridge is in forwarding mode and created by hand. If the same
> centos VM is migrated into an all-in-one OpenStack Pike host, where
> the bridge is managed by neutron, the ssh connection works again
> without any issue. In all cases I am talking about the latest centos
> openssh server, and the default ssh server configuration file.
> 
> So, what do you think? Where should I look further to understand what
> exactly causes this behavior?
> 
> Many thanks,
> Adrian

These symptoms sound like an MTU mismatch.
The padding is not related. More likely, the issue is that one side
is sending a larger frame than the MTU of the underlying interface.
Since the bridge is a pure layer 2 interface, it has not choice
but to drop any frame where the size is greater than the MTU.
