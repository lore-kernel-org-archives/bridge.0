Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=CH4Cqkze8t4l45XYWCuTZvKy+hVxN4PmAcglKtlZvuc=;
	b=OuGMQGbJeW417qjiRN9l1c6xxDVEutj2ISyFDMFcWZ8x65lxxkEWSxZshldZblB5Xt
	ChM+fQfa777ew+AyH+7/zDSfPqqTmwo+2bFo6cz+OCYD5CYjBrfGYXcSf1WfuZ7dsQHi
	mK+n+sckT2YeahiwBtPO0dsHedH/NppXsJKxyxhHibl3CCti72S/5sXzvYibG4snZnfK
	cG4XzzWH5fOISZDRV0d8t04HE50r3tZgDTMXZ4EvrmXyXpcnOHmn7nlOQWrlHRZG1gYu
	AwAkivh0l69H5W/lAht4k0Q8RHkZ9LUxTULZkDWuAPrAdheqy0dK/4Z0PEmAlatgMgfW
	TIgg==
Date: Fri, 15 Dec 2017 07:55:12 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20171215075512.6138a258@xeon-e3>
In-Reply-To: <CA+k9h3PudMEAC7geZ7PPvR4m-6_9X4bFnWcvrBkb4sst0q3v8Q@mail.gmail.com>
References: <CA+k9h3PudMEAC7geZ7PPvR4m-6_9X4bFnWcvrBkb4sst0q3v8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] linux bridge does not forward arp reply back packets
 in a vmware vm
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Adrian P <adrian27oradea@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Fri, 15 Dec 2017 15:37:39 +0200
Adrian P <adrian27oradea@gmail.com> wrote:

> Hello,
> 
> I have a strange issue with a linux bridge created by
> openstack-neutron (pike release). This linux bridge is hosted in a
> vmware VM running latest CentOS 7, with a single network interface in
> promiscuous mode.
> 
> From openstack neutron perspective, the networking setup is simple: a
> single flat external provider network, with a single cirros VM
> instance connected to it.
> 
> Therefore, in the linux bridge running in the vmware host, I have 3 interfaces:
> 
> # brctl show
> bridge name     bridge id               STP enabled     interfaces
> brq025a9a94-58          8000.005056a6b378       no              ens160
>                                                         tap2eb4cad6-cd
>    <----- neutron DHCP agent tap interface
>                                                         tap6d31a191-9f
>    <----- cirros VM instance tap interface
> 
> The ens160 is the "physical" CentOS 7 host interface, that is in
> promiscuous mode.
> 
> The  tap2eb4cad6-cd tap interface is the neutron DHCP agent interface,
> and the tap6d31a191-9f tap interface is used by the cirros VM
> instance.
> 
> The problem is the following:
> 
> With a tcpdump, I am able to see the arp request (ARP, Request who-has
> 10.20.21.1 tell 10.20.21.233) going out from the cirros VM instance on
> tap interface tap6d31a191-9f, and well as on the bridge itself
> (brq025a9a94-58). However, the reply back to the arp request (Reply
> 10.20.21.1 is-at 00:17:08:c4:52:80) does not reach the cirros VM
> instance anymore. With tcpdump, I am able to see the arp reply back
> packets in the bridge (brq025a9a94-58), however they do not show up
> anymore on the cirros VM instance tap interface tap6d31a191-9f.
> 
> To me it seems that for whatever reason, the bridge does not forward
> the arp reply back packets to the cirros VM tap interface, and I do
> not understand why. The strange thing is that after a while, for
> apparently no reason, a single arp reply back packet gets through the
> bridge and the tap interface, and the arp table gets updated with
> correct IP address in the cirros VM instance. However, if I clean up
> the arp table in the cirros VM instance, it takes again 10 to 15
> minutes of continuously sending arp requests, until a single arp reply
> back packets gets through.
> 
> I was banging my head to the table for a few days with this issue, and
> finally, for apparent no reason, I manually configured the bridge max
> aging time to 0, to convert it in a hub, and from that moment
> everything started to work without any issue. Still, I do no
> understand why is this happening, and obviously I cannot manually set
> up the bridge aging time to 0 all the time in all the bridges
> openstack neutron creates automatically.
> 
> Any thoughts?
> 
> Many thanks in advance.
> 
> Best regards,
> Adrian

Does each tap instance and the ens160 have a different and valid Ethernet
address?  Also make sure the these are in the bridge forwarding table.
