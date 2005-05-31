Date: Tue, 31 May 2005 09:29:45 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Source code bug or doubt - Not freeing port struct
Message-ID: <20050531092945.74ae1fcc@dxpl.pdx.osdl.net>
In-Reply-To: <6.1.2.0.2.20050531103813.03ffb590@luna.tlmat.unican.es>
References: <5.2.0.9.1.20050530155338.024bd488@mailhost.csse.uwa.edu.au>
	<1117523207.32760.84.camel@buttercup>
	<6.1.2.0.2.20050531103813.03ffb590@luna.tlmat.unican.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Jorge Lanza <jlanza@tlmat.unican.es>
Cc: bridge@lists.osdl.org

On Tue, 31 May 2005 10:45:28 +0200
Jorge Lanza <jlanza@tlmat.unican.es> wrote:

> Hi all.
> 
> During the last few days I've been going through the code in order to 
> understand how can I hack it to make the things I want to a packet on layer 2.
> First of all, congratulations. I have learnt a lot.
> 
> However I have a doubt. In n<http://lxr.linux.no/ident?i=new_nbp>ew_nbp() 
> funtion in br_if.c you make a kalloc for the port. While reading the code I 
> haven't seen any kfree for that memory, which should be done in 
> <http://lxr.linux.no/ident?i=del_nbp>del_nbp or similar functions. In 
> <http://lxr.linux.no/ident?i=destroy_nbp>destroy_nbp you set the pointer to 
> null, but I think that's not enough. I don't know if it is a bug or is sth 
> that is done somewhere else.

What kernel version?
	For 2.6
		kmalloc of port data is in br_if:new_nbp
		kfree is done by:
		del_nbp calls destroy_nbp (via rcu)
		   calls br_sysfs_freeif which does kobject_put(of port kobj)
			when ref == 0 calls brport_release (through brport_ktype)

This complexity comes because application could have /sys/class/net/ethX/brif/port_id
or other file open, in which case the bridge port can't be deleted. Until last
reference is zero.
		
