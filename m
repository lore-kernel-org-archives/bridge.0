Date: Tue, 13 Feb 2007 12:03:43 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070213120343.076236f0@freekitty>
In-Reply-To: <OF2FBFFA89.57E7E5F8-ON85257281.006D931D-85257281.006DD7AE@smsc.com>
References: <20070213115356.021218bb@freekitty>
	<OF2FBFFA89.57E7E5F8-ON85257281.006D931D-85257281.006DD7AE@smsc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] is there RSTP for 2.6 kernel available?
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Marc.Obbad@smsc.com
Cc: bridge@lists.osdl.org

On Tue, 13 Feb 2007 14:59:46 -0500
Marc.Obbad@smsc.com wrote:

> Thanks Steve.
> I am trying to reuse RSTP for 2.4 kernel for 2.6 kernel  and wondering if I am on the wrong path. I am not sure if RSTP
> for 2.4 is working to start with.
> 
> Thanks,
> 
> -Marc

The path for 2.6 is going to be having a user space daemon. There are changes needed
to handling of FDB, and a better way to send/receive STP frames.  Also, I am not sure
what the best migration plan is. Do we need to keep the kernel STP around (as a config
option); should kernel start the daemon (usermode_helper), etc...

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
