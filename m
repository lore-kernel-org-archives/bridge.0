Date: Sat, 27 Nov 2010 14:16:47 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20101127141647.6814f62f@nehalam>
In-Reply-To: <AANLkTikviZkym71gVp6BZUeiqHjbARhjB-J-mnE_5A6J@mail.gmail.com>
References: <AANLkTikviZkym71gVp6BZUeiqHjbARhjB-J-mnE_5A6J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Disable mac address learning
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benjamin Vanheuverzwijn <bvanheu@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Sat, 27 Nov 2010 16:46:34 -0500
Benjamin Vanheuverzwijn <bvanheu@gmail.com> wrote:

> Hi,
> 
> Is there a way to disable the mac address learning in linux using "brctl" or
> custom code so any packet sent to the bridge will be flooded in each
> interfaces.
> 
> I would like to do something similar as OpenBSD:
> $ brconfig <bridge> -learn <iface>
> $ man brconfig
> ...
>      -learn interface
>              Mark interface so that the source address of packets received
>              from interface are not entered into the address cache.
> ...
> 
> I tried to search on google and on the mailing-list without success.

Just set ageing time to zero no need for special config option.
