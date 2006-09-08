Date: Fri, 8 Sep 2006 15:59:42 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060908155942.361097e1@localhost.localdomain>
In-Reply-To: <82b0add70609081551m63a2264rbc79e9ea0b2c055c@mail.gmail.com>
References: <82b0add70609081551m63a2264rbc79e9ea0b2c055c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] skb timestamp set in bridge?
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Joubert Berger <joubertb@gmail.com>
Cc: bridge@lists.osdl.org

On Fri, 8 Sep 2006 18:51:18 -0400
"Joubert Berger" <joubertb@gmail.com> wrote:

> In 2.4, I relied on the skb->stamp to contain the timestamp of when
> the packet entered the bridge.  In 2.6, I don't seem to be seeing this
> behaviour.  Is this correct?  If so, what is the best place for me to
> grab the timestamp of the packet entering the bridge.
> 
> TIA.
> 

What code do you have that needs the timestamp.
2.6 doesn't enable timestamps unless some application needs it.

If it is a kernel driver, then it should call net_enable_timestamp()
when loaded and net_disable_timestamp() when unloaded.
