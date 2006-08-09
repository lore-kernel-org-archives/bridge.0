Date: Wed, 9 Aug 2006 10:05:32 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060809100532.51047ce4@localhost.localdomain>
In-Reply-To: <116823230608090302h8c7a2cbwadb233d8056bb3e2@mail.gmail.com>
References: <449AA3EF.9080300@kingsley.co.za>
	<20060707114918.26b099ba@dxpl.pdx.osdl.net>
	<116823230608072305g1ef9f73la91213524d74b17c@mail.gmail.com>
	<20060808113025.6dc41308@localhost.localdomain>
	<116823230608090302h8c7a2cbwadb233d8056bb3e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Network seperation and ethernet bridge...
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "He, Zhenjie" <hezhenjie@gmail.com>
Cc: bridge@lists.osdl.org

On Wed, 9 Aug 2006 18:02:03 +0800
"He, Zhenjie" <hezhenjie@gmail.com> wrote:

> Thank you for your reply.
> On 8/9/06, Stephen Hemminger <shemminger@osdl.org> wrote:
> >
> > On Tue, 8 Aug 2006 14:05:03 +0800
> > "He, Zhenjie" <hezhenjie@gmail.com> wrote:
> >
> > > Hi, Stephen/all,
> > >
> > > The situation I meet is similar as this.
> > >
> > > I want to capture BPDU packets go through the Linux bridge,
> >
> > Simpler just to use something like AF_PACKET, or tools like pcapture?
> 
> 
> I intend to use a Linux bridge with stp enable in the internal to generate
> BPDU packets, and use ethereal or tcpdump to capture packets in the other
> side.
> Is there other ways to generate BPDU?

You could use LLC to send/receive spanning tree BPDU's.
Or you could use the Ethernet tap driver (tuntap) and attach a pseudo-device
to a bridge.
