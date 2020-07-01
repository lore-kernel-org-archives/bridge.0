Return-Path: <mcgrof@gmail.com>
From: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <20200701134635.GR4332@42.do-not-panic.com>
References: <20200624144311.GA5839@infradead.org>
 <9e767819-9bbe-2181-521e-4d8ca28ca4f7@de.ibm.com>
 <20200624160953.GH4332@42.do-not-panic.com>
 <ea41e2a9-61f7-aec1-79e5-7b08b6dd5119@de.ibm.com>
 <4e27098e-ac8d-98f0-3a9a-ea25242e24ec@de.ibm.com>
 <4d8fbcea-a892-3453-091f-d57c03f9aa90@de.ibm.com>
 <1263e370-7cee-24d8-b98c-117bf7c90a83@de.ibm.com>
 <20200626025410.GJ4332@42.do-not-panic.com>
 <20200630175704.GO13911@42.do-not-panic.com>
 <b24d8dae-1872-ba2c-acd4-ed46c0781317@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b24d8dae-1872-ba2c-acd4-ed46c0781317@de.ibm.com>
Subject: Re: [Bridge] linux-next: umh: fix processed error when
 UMH_WAIT_PROC is used seems to break linux bridge on s390x (bisected)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Wed, 01 Jul 2020 13:46:39 -0000
To: Christian Borntraeger <borntraeger@de.ibm.com>, Jessica Yu <jeyu@kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: ast@kernel.org, jarkko.sakkinen@linux.intel.com, philipp.reisner@linbit.com, bfields@fieldses.org, keyrings@vger.kernel.org, christian.brauner@ubuntu.com, yangtiezhu@loongson.cn, linux-s390 <linux-s390@vger.kernel.org>, bridge@lists.linux-foundation.org, jmorris@namei.org, Christoph Hellwig <hch@infradead.org>, kuba@kernel.org, serge@hallyn.com, keescook@chromium.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, josh@joshtriplett.org, slyfox@gentoo.org, viro@zeniv.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>, axboe@kernel.dk, dhowells@redhat.com, linux-nfs@vger.kernel.org, chainsaw@gentoo.org, ravenexp@gmail.com, gregkh@linuxfoundation.org, markward@linux.ibm.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, chuck.lever@oracle.com, "Eric W. Biederman" <ebiederm@xmission.com>, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, lars.ellenberg@linbit.com, davem@davemloft.net

On Wed, Jul 01, 2020 at 12:08:11PM +0200, Christian Borntraeger wrote:
> dmesg attached
> [   14.438482] virbr0: port 1(virbr0-nic) entered blocking state
> [   14.438485] virbr0: port 1(virbr0-nic) entered disabled state
> [   14.438635] device virbr0-nic entered promiscuous mode
> [   14.439654] umh: sub_info->path: /sbin/bridge-stp
> [   14.439656] /sbin/bridge-stp 
> [   14.439656] virbr0 
> [   14.439656] start 

OK so what we seem to want to debug is the umh call for:

/sbin/bridge-stp virbr0 start

> [   14.439734] == ret: 00
> [   14.439735] == KWIFEXITED(ret): 01
> [   14.439736] KWEXITSTATUS(ret): 0

Its not clear if this is the respective return value, but now
that we have a clue that this is the the only non-modprobe
call, we should have a clearer certainty that this is the
issue.

Indeed my patch "umh: fix processed error when UMH_WAIT_PROC is used"
did modify bridge-stp in the following way:

diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index ba55851fe132..bdd94b45396b 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -133,14 +133,8 @@ static int br_stp_call_user(struct net_bridge *br, char *arg)
 
 	/* call userspace STP and report program errors */
 	rc = call_usermodehelper(BR_STP_PROG, argv, envp, UMH_WAIT_PROC);
-	if (rc > 0) {
-		if (rc & 0xff)
-			br_debug(br, BR_STP_PROG " received signal %d\n",
-				 rc & 0x7f);
-		else
-			br_debug(br, BR_STP_PROG " exited with code %d\n",
-				 (rc >> 8) & 0xff);
-	}
+	if (rc != 0)
+		br_debug(br, BR_STP_PROG " failed with exit code %d\n", rc);
 
 	return rc;
 }

If you look at this carefully though you'll notice that the change just
modifies *when* we issue the debug print. The more important relevant
part of the patch however was that we now do return a correct error
value when the call fails.

More importantly, depending on if an error or not we run the kernel STP
or userspace STP later:

static void br_stp_start(struct net_bridge *br)
{
	int err = -ENOENT;

	if (net_eq(dev_net(br->dev), &init_net))
		err = br_stp_call_user(br, "start");

	if (err && err != -ENOENT)
		br_err(br, "failed to start userspace STP (%d)\n", err);

	spin_lock_bh(&br->lock);

	if (br->bridge_forward_delay < BR_MIN_FORWARD_DELAY)
		__br_set_forward_delay(br, BR_MIN_FORWARD_DELAY);
	else if (br->bridge_forward_delay > BR_MAX_FORWARD_DELAY)
		__br_set_forward_delay(br, BR_MAX_FORWARD_DELAY);

--------------------->  can you enable debug print for this to see what
--------------------->  you end up using?
	if (!err) {
		br->stp_enabled = BR_USER_STP;
		br_debug(br, "userspace STP started\n");
	} else {
		br->stp_enabled = BR_KERNEL_STP;
		br_debug(br, "using kernel STP\n");

		/* To start timers on any ports left in blocking */
		if (br->dev->flags & IFF_UP)
			mod_timer(&br->hello_timer, jiffies + br->hello_time);
		br_port_state_selection(br);
	}
----------------->

	spin_unlock_bh(&br->lock);
}

