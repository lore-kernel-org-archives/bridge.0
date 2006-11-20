Date: Mon, 20 Nov 2006 08:01:02 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061120080102.66b03991@localhost.localdomain>
In-Reply-To: <49002b820611191955i1928c129ic93d5ce8b014b5ff@mail.gmail.com>
References: <49002b820611170149n645e35e6n76edc98fe6c9596@mail.gmail.com>
	<915136920611180514q663e65d1oec82391ed3fac700@mail.gmail.com>
	<49002b820611180825u628eb95cud9d52b0125a645be@mail.gmail.com>
	<915136920611190902q33930830oe414066422c3d995@mail.gmail.com>
	<49002b820611191952y208408a7q40d8f0160024c99d@mail.gmail.com>
	<49002b820611191955i1928c129ic93d5ce8b014b5ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge physical to several dummy interface
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: d tbsky <tbskyd@gmail.com>
Cc: bridge@lists.osdl.org

On Mon, 20 Nov 2006 11:55:12 +0800
"d tbsky" <tbskyd@gmail.com> wrote:

> hi:
> >    my purpose is to get several ip address  from dhcp server via single
> > ethernet card, like xen or vmware can do.
> >
> > Regards,
> > sky_li
> >

That isn't going to work for a number of reasons. Probably the biggest is
that Linux doesn't bind IP addresses to interfaces, so the ARP etc is going
to be messed up.  You need to have separated IP stacks, like Xen, UML, etc
to make this work.
