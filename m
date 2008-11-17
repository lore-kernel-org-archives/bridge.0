Message-ID: <49213FC5.4040001@sysnetsistemi.it>
Date: Mon, 17 Nov 2008 10:56:21 +0100
From: Francesco Dolcini <fdolcini@sysnetsistemi.it>
MIME-Version: 1.0
References: <282915.85653.qm@web8807.mail.in.yahoo.com>
In-Reply-To: <282915.85653.qm@web8807.mail.in.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge ports needlessly going through learning stage
 when	STP is disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

rahul bhardwaj wrote:
> Is this the right behavior ? The 15 to 30 second delay before the 
> port moves to Forwarding state can be frustrating, as you don't
> expect it, and for that period of time, start to think there is
> something else wrong in the network's configuration. Is there any
> place in the code where I do some change to resolve this issue.

At the moment the normal way to handle this is "brctl setfd $BR_DEV 0"

-Francesco
