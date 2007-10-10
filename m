Message-ID: <470CE5EB.7010501@sysnetsistemi.it>
Date: Wed, 10 Oct 2007 16:47:07 +0200
From: Francesco Dolcini <fdolcini@sysnetsistemi.it>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH] stp timer fix, linux version 2.4
References: <20071009125737.GA19446@fd.sysnet.local>
In-Reply-To: <20071009125737.GA19446@fd.sysnet.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: bridge@lists.linux-foundation.org

Francesco Dolcini wrote:
> In kernel 2.4, br_record_config_information update message_age_timer
> with jiffies in the past. In 2.6 is already fixed and a similar fix
> appeared in v2.4.35.3.
sorry, just broken.
