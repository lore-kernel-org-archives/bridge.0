Date: Mon, 11 Sep 2006 12:53:27 -0700
From: David Kimdon <david.kimdon@devicescape.com>
Message-ID: <20060911195327.GA5754@devicescape.com>
References: <20060911174928.GA3451@devicescape.com>
	<bdfc5d6e0609111155s58677c8bx2533330a18238aca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdfc5d6e0609111155s58677c8bx2533330a18238aca@mail.gmail.com>
Subject: Re: [Bridge] RFC: [PATCH] bridge vlan integration
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Andy Gospodarek <andy@greyhouse.net>
Cc: bridge@lists.osdl.org

On Mon, Sep 11, 2006 at 02:55:47PM -0400, Andy Gospodarek wrote:
> On 9/11/06, David Kimdon <david.kimdon@devicescape.com> wrote:
> David,
> 
> It looks like this code specifically ignores (which is OK for now) and
> clears (which is not OK) the frame's 802.1p priority.i

ah, yes, good point.

>   Have you tested
> priority-tagged frames to see if they are passed correctly?  

well, they get mapped to the correct vlan (untagged), but, yes, we
lose the priority.  

> Something like this would probably be fine:
yes, thanks.

-David

