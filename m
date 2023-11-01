Return-Path: <konstantin@linuxfoundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3FB2C84CC9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CC188494D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1698869458;
 bh=qWq60dsjYKVO5hHhs5WPNbgi5lyED87df/YUqtTpgb8=;
 h=Date:From:To:Subject:From;
 b=yBcGlUHAIH4+DORbqzS0Ces0g4jwdZo1rmaYs/M0DGlcASToPqKqMsHfugv4Yjdnq
 bVGBpN+/DztApGFk+Ne4Jq45zZyq7AhAXFpEyuwLLqvf4XSf7KdsjK+5VXw9aYeZJz
 74DAmfNNgWgU7atxpZtp7zJUThscdqf0MtX1D64w=
Date: Wed, 1 Nov 2023 16:10:56 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Message-ID: <20231101-enormous-salmon-of-coffee-7ebb9a@nitro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Bridge] PSA: the bridge list will be moving to lists.linux.dev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello, all:

The mailman-2 system running on lists.linux-foundation.org is being
decommissioned, so all lists currently hosted there will be found new homes.
*On November 7*, The bridge list will be migrated to live on lists.linux.dev,
but the impact of this move should be minor:

1. The new canonical list address will be bridge@lists.linux.dev.

2. *The old address will continue to work* for the foreseeable future, so any
   existing conversations can continue and any new messages sent to the old
   list address will be properly delivered to all subscribers.

3. All members will be automatically subscribed to the new list, so no action
   is required on anyone's part to keep receiving list mail.

4. The list will be archived on https://lore.kernel.org/bridge/ with all prior
   archives automatically imported.

5. The List-ID header will change, regardless to which address the message is
   sent:

   before: List-Id: <bridge.lists.linux-foundation.org>
    after: List-Id: <bridge.lists.linux.dev>

   You will need to update your filtering rules if you filter based on the
   contents of that header (on or after November 7).

6. The mailman footer will no longer be added to message bodies and the
   subject will no longer be modified to insert [bridge] (because this
   violates DMARC).

7. Subscribing and unsubscribing will be done using the mlmmj supported
   commands, documented at https://subspace.kernel.org/subscribing.html

Please let me know if you have any questions or concerns. Otherwise, I will
follow up on November 7 after the move has been completed.

Best regards,
-K
