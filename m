Date: Thu, 29 May 2008 15:58:19 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080529155819.7bce2324@extreme>
In-Reply-To: <1E3D081C7B502B4A988F643E604CF96305610E@INDEXCH.corp.proxim.com>
References: <1E3D081C7B502B4A988F643E604CF96305610E@INDEXCH.corp.proxim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Please help me to know MAX Forwarding Table Size in
 Linux Bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ritesh Majumdar <ritesh@proxim.com>
Cc: bridge@lists.osdl.org

On Wed, 28 May 2008 23:03:29 -0700
"Ritesh Majumdar" <ritesh@proxim.com> wrote:

> 
> Hello,
> 
> Thanks for putting such a nice document in net on Linux bridge. actually
> I am working on integrating Linux bridge module with embedded OS which
> is running Linux. It is very important for me to know maximum number of
> MAC addresses Linux bridge can hold (I am using kernel 2.6.20).my
> requirement is about 10000 MAC addresses learning capacity in forwarding
> table.
> 
> Is it possible for kernel to learn 10000 MAC addresses ...??
> 
> Hope someone will help me out with this, after looking through web over
> two days I couldn't find any solution yet.
> 
> Many Thanks,
> Ritesh.
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

The only limitation is kernel memory, so 10000 doesn't seem that large.
Easy enough to test it and find out (using a script or various DoS tests).
