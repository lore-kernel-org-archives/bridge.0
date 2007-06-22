Date: Thu, 21 Jun 2007 18:38:49 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Can a bridge be put into 'hub' mode?
Message-ID: <20070621183849.053ca37b@oldman>
In-Reply-To: <467AC4A6.6040207@candelatech.com>
References: <467AC4A6.6040207@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ben Greear <greearb@candelatech.com>
Cc: bridge@lists.linux-foundation.org

On Thu, 21 Jun 2007 11:34:14 -0700
Ben Greear <greearb@candelatech.com> wrote:

> Is there any way to keep a bridge from doing *any* MAC learning
> and thus force it into HUB mode?
> 
> Thanks,
> Ben
> 

set the ageing timeout to zero
